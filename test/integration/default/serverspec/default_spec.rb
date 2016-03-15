#require 'spec_helper'
#require_relative '../../../kitchen/data/spec_helper'
# require_relative '/tmp/verifier/suites/serverspec/spec_helper'
# require_relative './spec_helper'
require_relative '/tmp/kitchen/data/spec_helper'

describe "BBS-provision-cookbook::default" do
  # describe package('git') do
  #   it {should be_installed}
  # end

  describe file('/etc/passwd') do
    it { should exist }
  end
end
