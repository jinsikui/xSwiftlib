#
#  Be sure to run `pod spec lint xSwiftlib.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name             = 'xSwiftlib'
  s.version          = '2.0.0.0'
  s.summary          = 'swift组件库'

  s.description      = <<-DESC
    swift组件库
                       DESC

  s.homepage         = 'https://github.com/jinsikui/xSwiftlib'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jinsikui' => '1811652374@qq.com' }
  s.source           = { :git => 'https://github.com/jinsikui/xSwiftlib.git'}
  s.ios.deployment_target = '9.0'
  s.source_files = 'Source/**/*', 'Source/*'
  s.dependency 'PromisesObjC'
  s.dependency 'PromisesSwift'
  s.dependency 'RxSwift'
  s.frameworks = 'UIKit', 'Foundation'
end
