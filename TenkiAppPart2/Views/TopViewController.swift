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
        
        prefectureButton?.rx.tap.bind(to: prefectureTapBinder).disposed(by: disposeBag)
        currentLocationButton?.rx.tap.bind(to: currentLocationTapBinder).disposed(by: disposeBag)
        weeklyButton?.rx.tap.bind(to: weeklyTapBinder).disposed(by: disposeBag)

    }
    
    private func showAlert(error: TopViewError) {
        present(viewModel.getErrorAlertView(error: error), animated: true, completion: nil)
    }
    
    private var prefectureTapBinder: Binder<()> {
        return Binder(self) { base, _  in
            let storyboard: UIStoryboard = UIStoryboard(name: "PrefectureTableView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "PrefectureTableView") as! PrefectureTableViewController
            self.navigationController?.pushViewController(nextView, animated: true)
        }
    }
    
    private var currentLocationTapBinder: Binder<()> {
        return Binder(self) { base, _  in
            // 位置情報取得の確認
            guard let coordinate = self.viewModel.getCoordinate() else {
                self.showAlert(error: .locationError)
                return
            }
            
            let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
            let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
            nextView.coordinate = (lat: coordinate.latitude, lon: coordinate.longitude)
            nextView.dateIsToday = true
            nextView.prefectureFlag = false
            self.present(nextView, animated: true, completion: nil)
        }
    }
    
    private var weeklyTapBinder: Binder<()> {
        return Binder(self) { base, _  in
            self.viewModel.queryCurrentLocationWeather() { result in
                switch result {
                case let .success(daily):
                    let storyboard: UIStoryboard = UIStoryboard(name: "WeeklyTableView", bundle: nil)
                    let nextView = storyboard.instantiateViewController(withIdentifier: "WeeklyTableView") as! WeeklyTableViewController
                    DispatchQueue.main.async {
                        nextView.dailyLists = .init(value: daily)
                        self.navigationController?.pushViewController(nextView, animated: true)
                    }
                case .failure(let error):
                    self.showAlert(error: error)
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

