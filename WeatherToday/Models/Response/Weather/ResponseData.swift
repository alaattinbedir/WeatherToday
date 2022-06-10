/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

public struct ResponseData : Mappable {
	var time : Int?
	var summary : String?
	var icon : String?
	var sunriseTime : Int?
	var sunsetTime : Int?
	var moonPhase : Double?
	var precipIntensity : Double?
	var precipIntensityMax : Double?
	var precipIntensityMaxTime : Int?
	var precipProbability : Double?
	var precipType : String?
    var temperature : Double?
	var temperatureHigh : Double?
	var temperatureHighTime : Int?
	var temperatureLow : Double?
	var temperatureLowTime : Int?
	var apparentTemperatureHigh : Double?
	var apparentTemperatureHighTime : Int?
	var apparentTemperatureLow : Double?
	var apparentTemperatureLowTime : Int?
	var dewPoint : Double?
	var humidity : Double?
	var pressure : Double?
	var windSpeed : Double?
	var windGust : Double?
	var windGustTime : Int?
	var windBearing : Int?
	var cloudCover : Double?
	var uvIndex : Int?
	var uvIndexTime : Int?
	var visibility : Double?
	var ozone : Double?
	var temperatureMin : Double?
	var temperatureMinTime : Int?
	var temperatureMax : Double?
	var temperatureMaxTime : Int?
	var apparentTemperatureMin : Double?
	var apparentTemperatureMinTime : Int?
	var apparentTemperatureMax : Double?
	var apparentTemperatureMaxTime : Int?

	public init?(map: Map) {

	}

	public mutating func mapping(map: Map) {

		time <- map["time"]
		summary <- map["summary"]
		icon <- map["icon"]
		sunriseTime <- map["sunriseTime"]
		sunsetTime <- map["sunsetTime"]
		moonPhase <- map["moonPhase"]
		precipIntensity <- map["precipIntensity"]
		precipIntensityMax <- map["precipIntensityMax"]
		precipIntensityMaxTime <- map["precipIntensityMaxTime"]
		precipProbability <- map["precipProbability"]
		precipType <- map["precipType"]
        temperature <- map["temperature"]
		temperatureHigh <- map["temperatureHigh"]
		temperatureHighTime <- map["temperatureHighTime"]
		temperatureLow <- map["temperatureLow"]
		temperatureLowTime <- map["temperatureLowTime"]
		apparentTemperatureHigh <- map["apparentTemperatureHigh"]
		apparentTemperatureHighTime <- map["apparentTemperatureHighTime"]
		apparentTemperatureLow <- map["apparentTemperatureLow"]
		apparentTemperatureLowTime <- map["apparentTemperatureLowTime"]
		dewPoint <- map["dewPoint"]
		humidity <- map["humidity"]
		pressure <- map["pressure"]
		windSpeed <- map["windSpeed"]
		windGust <- map["windGust"]
		windGustTime <- map["windGustTime"]
		windBearing <- map["windBearing"]
		cloudCover <- map["cloudCover"]
		uvIndex <- map["uvIndex"]
		uvIndexTime <- map["uvIndexTime"]
		visibility <- map["visibility"]
		ozone <- map["ozone"]
		temperatureMin <- map["temperatureMin"]
		temperatureMinTime <- map["temperatureMinTime"]
		temperatureMax <- map["temperatureMax"]
		temperatureMaxTime <- map["temperatureMaxTime"]
		apparentTemperatureMin <- map["apparentTemperatureMin"]
		apparentTemperatureMinTime <- map["apparentTemperatureMinTime"]
		apparentTemperatureMax <- map["apparentTemperatureMax"]
		apparentTemperatureMaxTime <- map["apparentTemperatureMaxTime"]
	}

}
