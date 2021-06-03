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
        
    private let disposeBag = DisposeBag()
    private var viewModel: WeeklyTableViewModel
    
    init(coordinate: Coordinate, dailyLists: BehaviorRelay<[Daily]>) {
        viewModel = WeeklyTableViewModel(coordinate: coordinate,
                                         dailyLists: dailyLists)

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                nextView.dailySelectedItem = self.viewModel.dailyLists.value[indexPath.row]
                self.present(nextView, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        viewModel.dailyLists.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
            cell.textLabel?.text = Util.unixToString(date: TimeInterval(element.dt))
        }
        .disposed(by: disposeBag)
    }
}
