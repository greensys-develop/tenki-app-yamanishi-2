//
//  TopViewModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import Foundation
import RxCocoa
import RxSwift
import CoreLocation

enum TopViewError: Error {
    case locationError
    case dailyNotFound
    case apiFailure(Error?)
}

final class TopViewModel {
    
    let disposeBag = DisposeBag()
    var daily: [Daily]?

    init() {
        // 現在地の取得
        LocationManager.shared.initialize()
    }
    
    func getCoordinate() -> CLLocationCoordinate2D? {
        return LocationManager.shared.coordinate
    }
    
    func queryCurrentLocationWeather(coordinate: CLLocationCoordinate2D) -> Single<Void> {
                
        // 週間天気のAPIを取得
        return WeatherAPIService.shared.sendRx(WeatherAPIService.WeeklyCurrentLocationWeatherRequest(coordinate: (lat: coordinate.latitude, lon: coordinate.longitude)))
            .map { (response) in
                guard let daily = response.daily, !daily.isEmpty else {
                    return
                }
                self.daily = daily
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
