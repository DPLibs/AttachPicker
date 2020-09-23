#
# Be sure to run `pod lib lint AttachPicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AttachPicker'
  s.version          = '0.2.0'
  s.summary          = 'A simple library for user access to gallery, camera and device documents.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'You can apply flexible customization to view controllers, set data types, specify static collections of variables for further quick use.'

  s.homepage         = 'https://github.com/dmitriyap11/AttachPicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dmitriy Polyakov' => 'dmitriyap11@gmail.com' }
  s.source           = { :git => 'https://github.com/dmitriyap11/AttachPicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.source_files = 'AttachPicker/Classes/**/*'
  s.swift_version = '4.2'
  
#   s.source_files  = 'NAME_OF_POD/Classes/*.{swift}'
#    s.source_files  = 'AttachPicker/Classes/*.{h,m,swift}'
  
  # s.resource_bundles = {
  #   'AttachPicker' => ['AttachPicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
