Pod::Spec.new do |s|
  s.name             = "InkKit"
  s.version          = "1.0"
  s.summary          = "Drawing and Geometry made easy on iOS - now in Swift!"
  s.homepage         = "https://github.com/shaps80/InkKit"
  s.license          = 'MIT'
  s.author           = { "Shaps" => "shapsuk@me.com" }
  s.source           = { :git => "https://github.com/shaps80/InkKit.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/shaps'
  s.platforms        = { :ios => '8.0' }
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes/**/*'
end
