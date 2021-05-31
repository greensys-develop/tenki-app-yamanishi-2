//
//  WeatherDetailViewController.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import UIKit
import RxCocoa
import RxSwift
import Moya
import PKHUD

class WeatherDetailViewController: UIViewController {
    
    var selectedItem: (name: String, queryName: String)?
    var coordinate: Coordinate = (lat: 0.0, lon: 0.0)
    let f = DateFormatter()
    private let disposeBag = DisposeBag()
    var dateIsToday = false
    var prefectureFlag = false
    var dailySelectedItem: Daily?
    var dailyLists: Observable<Daily>?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var humidilyLabel: UILabel!
    @IBOutlet weak var cloudsLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    @IBOutlet weak var rainyPercentLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDate()
        initSetupView()
        setupMoya()
        
        // rx
        cancelButton?.rx.tap.bind(to: cancelButtonTapBinder).disposed(by: disposeBag)
    }
    
    private func apiSetupViews(data: WeatherModel) {
        titleLabel.text = data.name
        maxTempLabel.text = "最高気温：" + String(round(data.main.temp_max - 273.15)) + "℃"
        minTempLabel.text = "最低気温：" + String(round(data.main.temp_min - 273.15)) + "℃"
        humidilyLabel.text = "湿度：" + String(data.main.humidity) + "%"
        if let weatherValue = data.weather.first {
            weatherLabel.text = "天気：" + (weatherValue.description)
            weatherImageView.setImageByDefault(with: weatherValue.icon)
        }
        cloudsLabel.isHidden = true
        uvIndexLabel.isHidden = true
        rainyPercentLabel.isHidden = true
    }
    
    private func apiSetupViews(data: Daily) {
        titleLabel.text = LocationManager.shared.placeName
        maxTempLabel.text = "最高気温：" + String(round(data.temp.max - 273.15)) + "℃"
        minTempLabel.text = "最低気温：" + String(round(data.temp.min - 273.15)) + "℃"
        humidilyLabel.text = "湿度：" + String(data.humidity) + "%"
        if let weatherValue = data.weather.first {
            weatherLabel.text = "天気：" + (weatherValue.description)
            weatherImageView.setImageByDefault(with: weatherValue.icon)
        }
        
        cloudsLabel.isHidden = false
        uvIndexLabel.isHidden = false
        rainyPercentLabel.isHidden = false
        cloudsLabel.text = "曇り：" + String(data.clouds) + "%"
        uvIndexLabel.text = "UVインデックス値：" + String(Int(round((data.uvi))))
        rainyPercentLabel.text = "降水確率：" + String(Int(round((data.pop * 100)))) + "%"
    }
    
    private func setupMoya() {
        if dateIsToday {
            // 今日の日付を表示
            dateLabel.text = f.string(from: Date())
            if prefectureFlag {
                if let item = selectedItem {
                    // 都道府県の天気を表示
                    let provider = MoyaProvider<PrefectureWeatherRequest>()
                    provider.request(PrefectureWeatherRequest(prefecture: item.name)) { (result) in
                        switch result {
                        case let .success(response):
                            let decoder = JSONDecoder()
                            let data = try! decoder.decode(WeatherModel.self, from: response.data)
                            self.apiSetupViews(data: data)
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
            } else {
                // 現在地の天気を表示
                let provider = MoyaProvider<CurrentLocationWeatherRequest>()
                provider.request(CurrentLocationWeatherRequest(coordinate: coordinate)) { (result) in
                    switch result {
                    case let .success(response):
                        let decoder = JSONDecoder()
                        let data = try! decoder.decode(WeatherModel.self, from: response.data)
                        self.apiSetupViews(data: data)
                    case let .failure(error):
                        print(error)
                    }
                }
            }
        } else if let daily = dailySelectedItem {
            apiSetupViews(data: daily)
        }
    }
    
    private var cancelButtonTapBinder: Binder<()> {
        return Binder(self) { base, _  in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func initSetupView() {
        titleLabel.text = ""
        dateLabel.text = f.string(from: Date())
        maxTempLabel.text = ""
        minTempLabel.text = ""
        humidilyLabel.text = ""
        weatherLabel.text = ""
        cloudsLabel.text = ""
        uvIndexLabel.text = ""
        rainyPercentLabel.text = ""
        
        cloudsLabel.isHidden = true
        uvIndexLabel.isHidden = true
        rainyPercentLabel.isHidden = true
    }
    
    // Dateセットアップ
    func setupDate() {
        f.timeStyle = .none
        f.dateStyle = .short
        f.locale = Locale(identifier: "ja_JP")
    }

}