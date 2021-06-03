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
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        return LocationManager.shared.coordinate
    }
    
    func queryCurrentLocationWeather(completion: @escaping (Result<WeatherResponse, TopViewError>) -> Void) {
        
        guard let coordinate = getCoordinate() else {
            completion(.failure(.locationError))
            return
        }
        
        WeatherAPIService().send(WeatherAPIService.CurrentLocationWeatherRequest(coordinate: (lat: coordinate.latitude, lon: coordinate.longitude))) { (result) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func queryPrefectureWeather(item: (name: String, queryName: String) ,completion: @escaping (Result<WeatherResponse, TopViewError>) -> Void ) {
        WeatherAPIService().send(WeatherAPIService.PrefectureWeatherRequest(prefecture: item.name)) { (result) in
            switch result {
            case let .success(response):
                completion(.success(response))
            case let .failure(error):
                completion(.failure(.apiFailure(error)))
            }
        }
    }
    
}
