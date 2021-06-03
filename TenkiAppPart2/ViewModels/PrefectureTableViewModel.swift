//
//  PrefectureTableViewModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/06/02.
//

import Foundation
import RxCocoa
import RxSwift

final class PrefectureTableViewModel {
    
    // 都道府県
    let prefectures = BehaviorRelay<[Prefecture]>(value: prefecturesArray)
    
}
