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
    
    // ι½ιεΊη
    let prefectures = BehaviorRelay<[Prefecture]>(value: prefecturesArray)
    
}
