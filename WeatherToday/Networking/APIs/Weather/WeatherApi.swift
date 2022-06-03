//
//  WeatherApi.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import ObjectMapper

// MARK: - Weather model extension

class WeatherApi {
    // Get weather data from service
    func fetchWeather(latitude:(Double),
                      longitude:(Double),
                      success:@escaping (WeatherResponse) -> Void,
                      failure:@escaping (MyError) -> Void) {
        
        // Set up current coordinate url
        let urlCoordinate = "\(latitude),\(longitude)"
        
        MySessionManager.sharedInstance.request(methotType:.get, urlCoordinate, success: { (responseJSON) in
            // Get json object from response
            let weather = responseJSON.object
            
            // Map json to Weather object
            guard let weatherObject:WeatherResponse = Mapper<WeatherResponse>().map(JSONObject: weather) else {
                let myError = MyError(errorCode: "MAPPING_RESPONSE_ERROR", errorMessage: NSLocalizedString("Error mapping response", comment: "comment"))
                failure(myError)
                return
            }
            
            // Send object to calling module
            success(weatherObject)
            
        }, failure: { (error) in
            print(error)
            failure(error)
        })
    }
}