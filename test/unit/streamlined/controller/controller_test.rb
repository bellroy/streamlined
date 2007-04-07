require File.join(File.dirname(__FILE__), '../../../test_helper')
require 'streamlined/controller'

class Streamlined::ControllerTest < Test::Unit::TestCase
  include FlexMock::TestCase
  include Streamlined::Controller::ClassMethods
  
  def test_exception_logging
    # TBD: something that gets coverage over exception logging in controller
    # c = Class.new
    # flexstub(c) {|stub|
    #   stub.should_receive(:hide_action).and_return(nil)
    #   stub.should_receive(:before_filter).and_return(nil)
    #   stub.should_receive(:require_dependencies).and_return(nil)
    #   stub.should_receive(:verify).and_return(nil)
    # }
    # c.send :include, Streamlined::Controller
    # c.acts_as_streamlined
    # c.new.initialize_with_streamlined_variables
  end
  
  def test_streamlined_model
    streamlined_model("Test")
    assert_equal "Test", model_name
    streamlined_model(self)
    assert_equal "test_streamlined_model(Streamlined::ControllerTest)", 
                 model_name, 
                 "streamlined_model should extract name property" 
  end
end