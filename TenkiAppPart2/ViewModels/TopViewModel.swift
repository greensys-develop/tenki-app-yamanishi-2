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
    
    func getErrorAlertView(error: TopViewError) -> UIAlertController {
        switch error {
        case .locationError:
            let alert: UIAlertController = UIAlertController(title: "位置情報が取得されていません。", message: "位置情報を取得しますか？", preferredStyle:  UIAlertController.Style.alert)
            let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default) {_ in
                // 設定画面に移行
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl)  {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
            }
            let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            alert.addAction(defaultAction)
            return alert

        default:
            let alert: UIAlertController = UIAlertController(title: "通信エラー",
                                                             message: "お天気情報を取得できません。",
                                                             preferredStyle:  UIAlertController.Style.alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(cancelAction)
            return alert

        }
    }
    
}
