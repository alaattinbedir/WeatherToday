/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Hourly : Mappable {
	var dt : Int?
	var temp : Double?
	var feels_like : Double?
	var pressure : Int?
	var humidity : Int?
	var dew_point : Double?
	var uvi : Double?
	var clouds : Int?
	var visibility : Int?
	var wind_speed : Double?
	var wind_deg : Int?
	var wind_gust : Double?
	var weather : [Weather]?
	var pop : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		dt <- map["dt"]
		temp <- map["temp"]
		feels_like <- map["feels_like"]
		pressure <- map["pressure"]
		humidity <- map["humidity"]
		dew_point <- map["dew_point"]
		uvi <- map["uvi"]
		clouds <- map["clouds"]
		visibility <- map["visibility"]
		wind_speed <- map["wind_speed"]
		wind_deg <- map["wind_deg"]
		wind_gust <- map["wind_gust"]
		weather <- map["weather"]
		pop <- map["pop"]
	}

}