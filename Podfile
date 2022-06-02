# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def shared_pods
  pod 'Alamofire', '4.9.1'
  pod 'SwiftyJSON'
  pod 'ObjectMapper'
  pod 'RxSwift', '~> 5'
  pod 'RxCocoa', '~> 5'
  pod 'OHHTTPStubs/Swift'
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


