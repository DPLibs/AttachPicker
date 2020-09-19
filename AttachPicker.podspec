Pod::Spec.new do |spec|
  spec.name         = "AttachPicker"
  spec.version      = "0.0.1"
  spec.summary      = "Library for convenient work with ImagePicker and DocumentPicker"
  spec.homepage     = "https://github.com/dmitriyap11/AttachPicker"
  spec.license      = "MIT (example)"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "Dmitriy Polyakov" => "dmitriyap11@gmail.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/dmitriyap11/AttachPicker.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"
  spec.public_header_files = "Classes/**/*.h"
  spec.framework  = "Foundation"
  spec.requires_arc = true
end
