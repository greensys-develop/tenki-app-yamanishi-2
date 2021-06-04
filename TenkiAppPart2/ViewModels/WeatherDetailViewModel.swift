//
//  WeatherDetailViewModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation

final class WeatherDetailViewModel {
    var data: WeatherResponse?
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        return LocationManager.shared.coordinate
    }
    
    func queryCurrentLocationWeather_Rx(coordinate: Coordinate) -> Single<Void> {
        return WeatherAPIService.shared.sendRx(WeatherAPIService.CurrentLocationWeatherRequest(coordinate: (lat: coordinate.lat, lon: coordinate.lon))).map { (response) in
            self.data = response
        }
    }
    
    func queryPrefectureWeather_Rx(prefecture: String) -> Single<Void> {
        return WeatherAPIService.shared.sendRx(WeatherAPIService.PrefectureWeatherRequest(prefecture: prefecture)).map { (response) in
            self.data = response
        }
    }
    
}
