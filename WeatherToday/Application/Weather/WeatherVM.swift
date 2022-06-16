//
//  WeatherVM.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 26.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

enum WeatherViewState: ViewState {
    case close
}

class WeatherVM: BaseViewModel {
    let disposeBag = DisposeBag()
    let cityName = BehaviorRelay<String>(value: "Barcelona")
    var currentLocation: (latitude:Double, longitude:Double) = (41.3874, 2.1686)
    let weather = BehaviorRelay<WeatherResponse?>(value: nil)
    
    let currentDate = BehaviorRelay<Int?>(value: nil)
    let weatherType = BehaviorRelay<String?>(value: nil)
    let currentCityTemp = BehaviorRelay<Double?>(value: nil)

    func closeButtonPressed() {
        state.send(WeatherViewState.close)
    }
}

extension WeatherVM {
    func fetchCurrentWeather() {
        // Get current weather
        WeatherApi().fetchWeather(latitude: currentLocation.latitude, longitude: currentLocation.longitude, succeed: { [weak self] (weather) in
            guard let self = self else { return }

            self.weather.accept(weather)
            self.currentDate.accept(weather.currently?.time)
            self.weatherType.accept(weather.currently?.summary)
            self.currentCityTemp.accept(weather.currently?.temperature)

            self.closeButtonPressed()

        }, failed: { (error) in
            print(error)
        })
    }
}
