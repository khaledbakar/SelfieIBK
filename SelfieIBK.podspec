#
# Be sure to run `pod lib lint SelfieIBK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SelfieIBK'
  s.version          = '0.1.0'
  s.summary          = 'SelfieIBK is framework for taking selfie.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'SelfieFBK is framework for taking pictures specifc (selfie) for example to identify client image you do not need to learn about camera or avfoundation you just press the button or action then moduale will apper take your photo and set it or retake it if you do not like it as you set it the image will send to you to use it wherever you want'
                       DESC

  s.homepage         = 'https://github.com/khaled bakar/SelfieIBK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'khaled bakar' => 'khaledbakar7@gmail.com' }
  s.source           = { :git => 'https://github.com/khaled bakar/SelfieIBK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.1'

  s.source_files = 'Source/**/*.swift'
  s.exclude_files = 'SelfieIBK/**/*.plist'

  s.swift_version = '5.0'
  s.platforms = {
      "ios": "14.1"
  }
  
  # s.resource_bundles = {
  #   'SelfieIBK' => ['SelfieIBK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit', 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
 # s.dependency 'TinyConstraints', '~> 4.0.0'
end
