#
# Be sure to run `pod lib lint IISecurity.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'IISecurity'
  s.version          = '0.3.0'
  s.summary          = 'IISecurity'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  IISecurity:
  1.引入了安全监测与性能处理代码
  2.引入CryptSwift代码
                       DESC

  s.homepage         = 'https://github.com/hatjs880328s/IISecurity'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hatjs880328s' => 'shanwzh@inspur.com' }
  s.source           = { :git => 'https://github.com/hatjs880328s/IISecurity.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files  = "IISecurity/Classes/**/*.swift"

  s.requires_arc = true

  s.swift_version = "4.2"

  s.cocoapods_version = '>= 1.4.0'

  s.pod_target_xcconfig = { 'SWIFT_OPTIMIZATION_LEVEL' => '-O', 'SWIFT_COMPILATION_MODE' => 'wholemodule', 'SWIFT_DISABLE_SAFETY_CHECKS' => 'YES', 'SWIFT_ENFORCE_EXCLUSIVE_ACCESS' => 'debug-only', 'GCC_UNROLL_LOOPS' => 'YES'}

  
  # s.resource_bundles = {
  #   'IISecurity' => ['IISecurity/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'IISwiftBaseUti'
  s.dependency 'IIBLL'
end
