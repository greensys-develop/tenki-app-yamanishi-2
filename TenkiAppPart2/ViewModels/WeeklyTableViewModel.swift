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
    let dailyLists: BehaviorRelay<[Daily]>

    init(dailyLists: BehaviorRelay<[Daily]>) {
        self.dailyLists = dailyLists
    }
}
