require File.dirname(__FILE__) + '/specs'

describe "When I verify an asp.net application which has NOT successfully been deployed" do

  before(:all) do
    @downloader = mock()
    @downloader.expects(:download).returns(Deploys.aspnet_failed)
    @verifier = WebsiteDeployVerifier.new(@downloader)
    @verifier.type = "aspnet"
    @verifier.url = "http://foo.com"
  end

  it "should it should raise an exception" do

    lambda { @verifier.execute }.should raise_exception(WebsiteDeployFailed)
  end
end

describe "When I do not specify a url to verify" do

  before(:all) do
    @verifier = WebsiteDeployVerifier.new(mock())
  end

  it "should raise an error" do
    lambda { @verifier.execute }.should raise_exception
  end
end

describe "When I verify an asp.net application which has successfully been deployed" do
  before(:all) do
    @downloader = mock()
    @downloader.expects(:download).returns(Deploys.aspnet_success)
    @verifier = WebsiteDeployVerifier.new(@downloader)
    @verifier.url = "http://foo.com"
    @verifier.type = "aspnet"
  end

  it "should it return true" do
    @verifier.execute.should == true
  end
end


class Deploys
  def self.method_missing(m, *args)
    return load(m)
  end
  
  private

  def self.load(name)
    return File.read(File.dirname(__FILE__) + "/sample_data/deploys/#{name}.html")
  end
end


