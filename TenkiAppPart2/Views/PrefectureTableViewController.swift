//
//  PrefectureTableViewController.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import UIKit
import RxSwift
import RxCocoa

class PrefectureTableViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var coordinate: Coordinate = (lat: 0.0, lon: 0.0)
    var isWeekly = false
    var dailyLists: Observable<[Daily]> = .just([])
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        // tableViewのセルをタップした時のメソッド
        let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                if self.isWeekly {
                    nextView.dailySelectedItem = self.dailyLists[indexPath.row]
                } else {
//                    nextView.selectedItem = prefecture[indexPath.row]
//                    nextView.prefectureFlag = true
//                    nextView.dateIsToday = true
                }
            })
            .disposed(by: disposeBag)
    }

//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isWeekly {
//            return dailyList.count
//        } else {
//            return prefecture.count
//        }
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        if isWeekly {
//            cell.textLabel?.text = Util.unixToString(date: TimeInterval(dailyList[indexPath.row].dt))
//        } else {
//            cell.textLabel!.text = prefecture[indexPath.row].name
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard: UIStoryboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
//        let nextView = storyboard.instantiateViewController(withIdentifier: "WeatherDetailView") as! WeatherDetailViewController
//        if isWeekly {
//            nextView.dailySelectedItem = dailyList[indexPath.row]
//        } else {
//            nextView.selectedItem = prefecture[indexPath.row]
//            nextView.prefectureFlag = true
//            nextView.dateIsToday = true
//        }
//        self.present(nextView, animated: true, completion: nil)
//    }

}
