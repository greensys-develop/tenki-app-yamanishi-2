//
//  WeeklyTableViewModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import Foundation
import RxCocoa
import RxSwift

final class WeeklyTableViewModel {
    let coordinate: Coordinate
    let dailyLists: BehaviorRelay<[Daily]>

    init(coordinate: Coordinate, dailyLists: BehaviorRelay<[Daily]>) {
        self.coordinate = coordinate
        self.dailyLists = dailyLists
    }
}
