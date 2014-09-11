Pod::Spec.new do |s|

  s.name         = "WZTransitionLabel"
  s.version      = "0.0.1"
  s.summary      = "WZTransitionLabel is a subclass of UILabel that provide custom transition when switching label's text."

  s.homepage     = "https://github.com/jasonhotsauce/WZTransitionLabel"

  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author       = { "Wenbin Zhang" => "wenbinzhang0802@gmail.com" }

  s.ios.deployment_target = '6.0'

  s.source       = { :git => "https://github.com/jasonhotsauce/WZTransitionLabel.git", :tag => s.version.to_s }

  s.source_files  = "WZTransitionLabel"

  s.frameworks = "UIKit", "Foundation"

  s.requires_arc = true

end
