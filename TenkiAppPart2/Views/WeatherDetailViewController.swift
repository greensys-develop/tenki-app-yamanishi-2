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

enum WeatherDetailView {
    case Prefecture
    case CurrentLocation
    case WeeklyCurrentLocation
}

class WeatherDetailViewController: UIViewController {
    
    var selectedItem: (name: String, queryName: String)?
    var coordinate: Coordinate = (lat: 0.0, lon: 0.0)
    
    var dailySelectedItem: Daily?
    
    var viewName: WeatherDetailView?
    
    let f = DateFormatter()
    
    private let disposeBag = DisposeBag()
    private let viewModel = WeatherDetailViewModel()
    
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
        
        // rx
        cancelButton?.rx.tap.bind(to: cancelButtonTapBinder).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let view = viewName else {
            return
        }
        
        initSetupView(view: view)
        setupMoya(view: view)
    }
    
    private func apiSetupViews(data: WeatherResponse) {
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
        dateLabel.text = Util.unixToString(date: TimeInterval(data.dt))
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
    
    private func setupMoya(view: WeatherDetailView) {
        switch view {
        
        case .Prefecture:
            dateLabel.text = f.string(from: Date())
            if let item = selectedItem {
                self.viewModel.queryPrefectureWeather_Rx(prefecture: item.name).subscribe {
                    guard let data = self.viewModel.data else { return }
                    self.apiSetupViews(data: data)
                } onError: { (error) in
                    print(error)
                }.disposed(by: disposeBag)
            }
            
        case .CurrentLocation:
            dateLabel.text = f.string(from: Date())
            
            self.viewModel.queryCurrentLocationWeather_Rx(coordinate: self.coordinate).subscribe {
                guard let data = self.viewModel.data else { return }
                self.apiSetupViews(data: data)
            } onError: { (error) in
                print(error)
            }.disposed(by: disposeBag)
            
        case .WeeklyCurrentLocation:
            if let daily = dailySelectedItem {
                apiSetupViews(data: daily)
            }
            
        default:
            break
        }
    }
    
    private var cancelButtonTapBinder: Binder<()> {
        return Binder(self) { base, _  in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //初期設定
    func initSetupView(view: WeatherDetailView) {
        switch view {
        case .Prefecture:
            navigationController?.title = "都道府県の本日の天気"
        case .CurrentLocation:
            navigationController?.title = "現在地の本日の天気"
        case .WeeklyCurrentLocation:
            navigationController?.title = "都道府県の週間天気"
        default:
            break
        }
        
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
