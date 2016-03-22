#require 'spec_helper'
#require_relative '../../../kitchen/data/spec_helper'
# require_relative '/tmp/verifier/suites/serverspec/spec_helper'
# require_relative './spec_helper'
require_relative 'c:\users\vagrant\AppData\Local\Temp\kitchen\data\spec_helper'

describe "BBS-provision-cookbook-windows::default" do
  describe user('biocbuild') do
    it { should exist }
  end

  describe file('c:\\downloads') do
    it {should exist}
    it {should be_directory}
    # this doesn't work: (why?)
    # with or without hostname. various permutations of backslashes...
    #it {should be_owned_by 'WIN-L976DG4D6CC\biocbuild'}
end


  describe file('c:\\downloads\\Rtools33.exe') do
    it {should exist}
  end

  describe file('c:\\Rtools') do
    it {should exist}
    it {should be_directory}
  end

  describe file('c:\\path.txt') do
    its(:content) { should match /Rtools/i}
  end

end
