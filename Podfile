# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
  pod 'Alamofire', '5.0.0-rc.2'
  pod 'AlamofireObjectMapper', '6.2.0'
  pod 'SwiftyJSON'
  pod 'ObjectMapper', '~> 3.5.1'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'OHHTTPStubs/Swift'
  pod 'Bond', '7.6.1'
  pod 'SnapKit', '~> 5.0.0'
  pod 'IQKeyboardManagerSwift'
  pod 'TextAttributes'
  pod 'Atributika'
  pod 'lottie-ios'
  pod 'CryptoSwift', '~> 1.0'
end

def testing_pods
  pod 'Quick', '~> 5.0.1'
  pod 'Nimble'
end

target 'WeatherToday' do
  use_frameworks!
  inhibit_all_warnings!
  shared_pods
end  

target 'WeatherTodayTests' do
  inherit! :search_paths
  inhibit_all_warnings!
  use_frameworks!
  shared_pods
  testing_pods
end

target 'WeatherTodayUITests' do
    # Pods for testing
end


