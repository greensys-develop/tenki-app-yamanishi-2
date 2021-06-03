//
//  WeeklyTableViewController.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import UIKit
import RxSwift
import RxCocoa

class WeeklyTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinate: Coordinate = (lat: 0.0, lon: 0.0)
    var dailyLists: BehaviorRelay<[Daily]> = .init(value: [])
    
    private let disposeBag = DisposeBag()
    private let viewModel = WeeklyTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupTapTableViewCell()
        
        navigationController?.title = "現在地の週間天気"
    }
    
    private func setupTapTableViewCell() {
        // tableViewのセルをタップした時のメソッド
        let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                nextView.dailySelectedItem = self.dailyLists.value[indexPath.row]
                self.present(nextView, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        dailyLists.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = Util.unixToString(date: TimeInterval(element.dt))
        }
        .disposed(by: disposeBag)
    }
}
