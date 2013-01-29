require 'spec_helper'
 
res_type_name = :netapp_qtree
res_type = Puppet::Type.type(res_type_name)
res_name = 'q_tree'

describe res_type do

  let(:provider) {
    prov = stub 'provider'
    prov.stubs(:name).returns(res_type_name)
    prov
  }
  let(:res_type) {
    val = res_type
    val.stubs(:defaultprovider).returns provider
    val
  }
  let(:resource) {
    res_type.new({:name => res_name})
  }

  it 'should have :name be its namevar' do
    res_type.key_attributes.should == [:name]
  end

  # Simple parameter tests
  parameter_tests = {
    :name => {
      :valid    => ["qtree", "test"],
      :invalid 	=> ["qtree test","qtree-test", "qtree#"], 
    },
    :volume => {
      :valid    => ["volume", "volume_test"],
      :invalid	=> ["volume data", "volume-test", "volume#"],
    }
  }
  it_should_behave_like "a puppet type", parameter_tests, res_type_name, res_name

end