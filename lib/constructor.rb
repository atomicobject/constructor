require 'constructor/constructor'

class Class 
  def _constructor_config #:nodoc:#
    # Inherit an existing config from an ancestor if possible
    @constructor_config ||= (@constructor_config ? @constructor_config : (superclass ? superclass._constructor_config.dup : nil)) || {}
  end
  
  # Access the constructor keys for this class
  def constructor_keys 
    # Inherit keys from an ancestor if possible
    @_ctor_keys ||= (@_ctor_keys ? @_ctor_keys : (superclass ? superclass.constructor_keys.dup : nil)) || []
  end
  
  # Defines an initialize method for the class that expects a hash
  # of named arguments
  #
  #
  #   class Horse
  #     construct :name, :breed, :weight
  #   end
  #   Horse.new :name => 'Ed', :breed => 'Mustang', :weight => 342
  def constructor(*attrs, &block)
    if superclass.constructor_keys.any?
      similar_keys = superclass.constructor_keys & attrs
      raise "Base class already has keys #{similar_keys.inspect}" unless similar_keys.empty?
    end
    
    # Look for embedded options in the listing:
    opts = attrs.find { |a| a.kind_of?(Hash) and attrs.delete(a) }
    do_accessors = opts.nil? ? false : opts[:accessors] == true
    do_readers = opts.nil? ? false : opts[:readers] == true
    _constructor_config[:require_args] = opts.nil? ? true : opts[:strict] != false
    _constructor_config[:super_args] = opts.nil? ? nil : opts[:super]
    if block_given?
      _constructor_config[:constructor_block] = block
    end

    attr_accessor(*attrs) if do_accessors
    attr_reader(*attrs) if do_readers
    
    # Remember all constructor keys
    @_ctor_keys = [attrs,superclass.constructor_keys].flatten
    
    # Build the new initialize method
    include Constructor
  end
end
