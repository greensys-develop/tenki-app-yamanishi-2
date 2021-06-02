//
//  PrefectureTableViewController.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import UIKit
import RxSwift
import RxCocoa

class PrefectureTableViewController: TopViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinate: Coordinate = (lat: 0.0, lon: 0.0)
    var dailyLists: BehaviorRelay<[Daily]> = .init(value: [])
    
    var isWeekly = false
    
    private let disposeBag = DisposeBag()
    private let viewModel = PrefectureTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTapTableViewCell()
    }
    
    private func setupTapTableViewCell() {
        // tableViewのセルをタップした時のメソッド
        let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.isWeekly {
                    nextView.dailySelectedItem = self.dailyLists.value[indexPath.row]
                } else {
                    nextView.selectedItem = prefecture[indexPath.row]
                    nextView.prefectureFlag = true
                    nextView.dateIsToday = true
                }
                self.present(nextView, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        // tableViewの表示
        if isWeekly {
            dailyLists.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = Util.unixToString(date: TimeInterval(element.dt))
                }
                .disposed(by: disposeBag)
        } else {
            prefectures.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element.name
                }
                .disposed(by: disposeBag)
        }
    }
}
