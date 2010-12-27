module Constructor #:nodoc:#
  def initialize(args = nil)
    config = self.class._constructor_config
    super(*config[:super_args]) if config[:super_args] && defined?(super)
    
    keys = self.class.constructor_keys
    if config[:require_args]
      # First, make sure we've got args of some kind
      unless args and args.keys and args.keys.size > 0 
        raise ArgumentError.new(keys)
      end
      # Scan for missing keys in the argument hash
      a_keys = args.keys
      missing = []
      keys.each do |ck|
        unless a_keys.member?(ck)
          missing << ck
        end
        a_keys.delete(ck) # Delete inbound keys as we address them
      end
      if missing.size > 0 || a_keys.size > 0
        raise ArgumentError.new(missing,a_keys)
      end
    end
    
    if args
      keys.each do |key|
        instance_variable_set "@#{key}", args[key]
      end
    end
    
    setup if respond_to?(:setup)
    
    if config[:constructor_block]
      instance_eval(&config[:constructor_block])
    end
  end
  
  # Fancy validation exception, based on missing and extraneous keys.
  class ArgumentError < RuntimeError #:nodoc:#
    def initialize(missing,rejected=[])
      err_msg = ''
      if missing.size > 0
        err_msg = "Missing constructor args [#{missing.join(',')}]"
      end
      if rejected.size > 0
        # Some inbound keys were not addressed earlier; this means they're unwanted
        if err_msg
          err_msg << "; " # Appending to earlier message about missing items
        else
          err_msg = ''
        end
        # Enumerate the rejected key names
        err_msg << "Rejected constructor args [#{rejected.join(',')}]"
      end
      super err_msg
    end
  end
end
