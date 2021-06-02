//
//  ViewController.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import UIKit
import RxSwift
import RxCocoa
import Moya
import PKHUD

class TopViewController: UIViewController {
    
    @IBOutlet weak var prefectureButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var weeklyButton: UIButton!
    
    let cornerRadiusInt: CGFloat = 5
    
    private let disposeBag = DisposeBag()
    private let viewModel = TopViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        prefectureButton?.rx.tap.bind(to: button1TapBinder).disposed(by: disposeBag)
        currentLocationButton?.rx.tap.bind(to: button2TapBinder).disposed(by: disposeBag)
        weeklyButton?.rx.tap.bind(to: button3TapBinder).disposed(by: disposeBag)
        
        // 現在地の取得
        LocationManager.shared.initialize()

    }
    
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "位置情報が取得されていません。", message: "位置情報を取得しますか？", preferredStyle:  UIAlertController.Style.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertAction.Style.default) {_ in
        // 設定画面に移行
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
              return
            }
            if UIApplication.shared.canOpenURL(settingsUrl)  {
              if #available(iOS 10.0, *) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                })
              }
              else  {
                UIApplication.shared.openURL(settingsUrl)
              }
            }
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(cancelAction)
        alert.addAction(defaultAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    private var button1TapBinder: Binder<()> {
        return Binder(self) { base, _  in
            let storyboard: UIStoryboard = UIStoryboard(name: "PrefectureTableView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "PrefectureTableView") as! PrefectureTableViewController
            nextView.navigationItem.title = "都道府県の本日の天気"
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    private var button2TapBinder: Binder<()> {
        return Binder(self) { base, _  in
            // 位置情報取得の確認
            guard let coordinate = LocationManager.shared.coordinate else {
                self.showAlert()
                return
            }
            
            let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
            nextView.coordinate = (lat: coordinate.latitude, lon: coordinate.longitude)
            nextView.dateIsToday = true
            nextView.prefectureFlag = false
            nextView.navigationItem.title = "現在地の本日の天気"
            self.present(nextView, animated: true, completion: nil)
        }
    }
    
    private var button3TapBinder: Binder<()> {
        return Binder(self) { base, _  in
            guard let coordinate = LocationManager.shared.coordinate else {
                self.showAlert()
                return
            }
            
            let storyboard: UIStoryboard = UIStoryboard(name: "WeeklyTableView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "WeeklyTableView") as! WeeklyTableViewController
            nextView.navigationItem.title = "現在地の週間天気"
            
            // 週間天気のAPIを取得
            WeatherAPIService().send(WeatherAPIService.WeeklyCurrentLocationWeatherRequest(coordinate: (lat: coordinate.latitude, lon: coordinate.longitude))) { (result) in
                switch result {
                case let .success(response):
                    guard let daily = response.daily, !daily.isEmpty else {
                        HUD.flash(.labeledError(title: "通信が正常動作できませんでした。", subtitle: nil))
                        return
                    }
                    DispatchQueue.main.async {
                        nextView.dailyLists = .init(value: daily)
                        self.navigationController?.pushViewController(nextView, animated: true)
                    }
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    private func setupViews() {
        prefectureButton?.layer.cornerRadius = cornerRadiusInt
        currentLocationButton?.layer.cornerRadius = cornerRadiusInt
        weeklyButton?.layer.cornerRadius = cornerRadiusInt
        
        prefectureButton?.tintColor = .gray
        currentLocationButton?.tintColor = .gray
        weeklyButton?.tintColor = .gray
    }

}

