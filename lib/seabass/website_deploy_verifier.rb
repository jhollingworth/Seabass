class WebsiteDeployFailed < Exception 
end

class WebsiteDeployVerifier

  attr_accessor :url, :type

  def initialize(downloader = Downloader.new)
    @downloader = downloader
    debugger
  end

  def execute()
    debugger
    raise "Url not specified" if @url.nil?
    raise "Application type not specified" if @type.nil?
    
    if (@downloader.download(@url) =~ /<title>Exception of type '.*' was thrown<\title>/) != nil

      raise WebsiteDeployFailed
    end
    true
  end
end

class WebsiteRegexs

  def self.aspnet()
    "<title>Exception of type '.*' was thrown.</title>"   
  end

end

class Downloader
  def download(url)
    
  end
end