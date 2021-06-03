//
//  TopViewModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import Foundation
import RxCocoa
import RxSwift

enum TopViewError: Error {
    case locationError
    case dailyNotFound
    case apiFailure(Error?)
}

final class TopViewModel {
    
    func queryCurrentLocationWeather(completion: @escaping (Result<[Daily], TopViewError>) -> Void) {
        guard let coordinate = LocationManager.shared.coordinate else {
            completion(.failure(.locationError))
            return
        }
        
        // 週間天気のAPIを取得
        WeatherAPIService().send(WeatherAPIService.WeeklyCurrentLocationWeatherRequest(coordinate: (lat: coordinate.latitude, lon: coordinate.longitude))) { (result) in
            switch result {
            case let .success(response):
                guard let daily = response.daily, !daily.isEmpty else {
                    completion(.failure(.dailyNotFound))
                    return
                }
                completion(.success(daily))
            case let .failure(error):
                completion(.failure(.apiFailure(error)))
            }
        }
    }
    
}
