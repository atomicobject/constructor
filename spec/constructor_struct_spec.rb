PROJ_DIR=File.expand_path(File.dirname(__FILE__) + "/../")
$: << PROJ_DIR + "/lib"
require 'constructor_struct'

describe ConstructorStruct, "#new" do
  before do
    AClass = ConstructorStruct.new(:hello, :world) unless defined?(AClass)
  end
  
  it "creates a new class with accessors given a set of symbols or strings" do
    AClass.new(:hello => "foo", :world => "bar").hello.should == "foo"
    AClass.new(:hello => "foo", :world => "bar").world.should == "bar"
  end
  
  it "creates a real class" do
    AClass.new.class.should == AClass
  end
  
  it "has the option of creating a strict accessors" do
    lambda { ConstructorStruct.new(:foo, :strict => true).new }.should raise_error(/missing.*args.*foo/i)
  end
  
  it "does not have the option of not creating accessors" do
    ConstructorStruct.new(:foo, :accessors => false).new(:foo => "bar").foo.should == "bar"
  end

  describe "equivalence" do
    before do
      @hello = "Hello"
      @world = "World"
      @args = { :hello => @hello, :world => @world }
      @target = AClass.new(@args)
    end

    it "uses all accessors" do
      [ nil, :hello, :world ].each do |field_to_alter|
        alt = AClass.new(:hello => @hello, :world => @world)

        unless field_to_alter
          # Base case: they should be equal
          @target.should == alt
          @target.eql?(alt).should be_true #should eql(alt)
        else
          # Change 1 field and see not equal
          alt.send("#{field_to_alter}=", "other data")
          @target.should_not == alt
          @target.should_not eql(alt)
        end
      end
    end

    it "will not compare to another class with same fields" do
      BClass = ConstructorStruct.new(:hello, :world)
      alt = BClass.new(:hello => @hello, :world => @world)
      @target.should_not == alt
      @target.should_not eql(alt)
    end
  end

  describe "extra method definitions" do
    NightTrain = ConstructorStruct.new(:beer, :conductor) do
      def setup
        @conductor ||= "Bill"
      end
    end

    it "lets you declare instance methods within a block" do
      night_train = NightTrain.new(:beer => "Founders")
      night_train.beer.should == "Founders"
      night_train.conductor.should == "Bill"

      other_train = NightTrain.new(:beer => "Bells", :conductor => "Dave")
      other_train.conductor.should == "Dave"
    end
  end

end
