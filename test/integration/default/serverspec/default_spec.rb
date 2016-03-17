#require 'spec_helper'
#require_relative '../../../kitchen/data/spec_helper'
# require_relative '/tmp/verifier/suites/serverspec/spec_helper'
# require_relative './spec_helper'
require_relative 'c:\users\vagrant\AppData\Local\Temp\kitchen\data\spec_helper'

describe "BBS-provision-cookbook-windows::default" do
  # describe package('git') do
  #   it {should be_installed}
  # end

  # argh, this fails, see
  # https://discourse.chef.io/t/should-exist-file-test-fails-on-windows-kitchen-serverspec/8008
  describe file('c:\\foo') do
    it { should exist }
  end

  describe file('c:\\bar') do
    it { should_not exist }
  end


end
