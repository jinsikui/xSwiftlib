# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

source 'https://github.com/CocoaPods/Specs.git'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
      config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
      config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
      # to compile the app for simulator, should exclude arm64 for simulator
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
      # make the pod deployment target consistent with the main project
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end

def common
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'SwiftyJSON'
  pod 'SnapKit'
  pod 'PromisesObjC'
  pod 'PromisesSwift'
  pod 'RxSwift'
  pod 'xUtil',    :git => "https://github.com/jinsikui/xUtil.git", :tag => 'v2.2.0-0'
  pod 'xUI',    :git => "https://github.com/jinsikui/xUI.git", :tag => 'v2.0.1-0'
  pod 'xNavigate',    :git => "https://github.com/jinsikui/xNavigate.git", :tag => 'v2.1.0-0'
  pod 'xAPI',    :git => "https://github.com/jinsikui/xAPI.git", :tag => 'v2.1.0-0'
  pod 'xTracking/Page',    :git => "https://github.com/jinsikui/xTracking.git", :tag => 'v2.2.0-0'
  pod 'xTracking/Expose',    :git => "https://github.com/jinsikui/xTracking.git", :tag => 'v2.2.0-0'
  pod 'ReactiveCocoa'
  pod 'ReactiveObjC'
  pod 'ReactiveObjCBridge'
  pod 'QMUIKit'
  pod 'JXCategoryView', '1.6.1'
  pod 'YYKit'
  pod 'WCDB', '~> 1.1.0'
  pod 'WCDB.swift', '~> 1.1.0'
  pod 'CryptoSwift', '1.5.1'
  
end

target 'xSwiftlib' do
    common
end

target 'xSwiftlibTests' do
    common
end

target 'xSwiftlibUITests' do
    common
end
