//
//  Prefecture.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Foundation
import RxCocoa
import RxSwift

struct Prefecture {
    let name: String
    let queryName: String
}

let prefecturesArray: [Prefecture] = [
    Prefecture(name: "北海道", queryName: "Hokkaido"),
    Prefecture(name: "青森県", queryName: "Aomori"),
    Prefecture(name: "岩手県", queryName: "Iwate"),
    Prefecture(name: "宮城県", queryName: "Miyagi"),
    Prefecture(name: "秋田県", queryName: "Akita"),
    Prefecture(name: "山形県", queryName: "Yamagata"),
    Prefecture(name: "福島県", queryName: "Fukushima"),
    Prefecture(name: "茨城県", queryName: "Ibaraki"),
    Prefecture(name: "栃木県", queryName: "Tochigi"),
    Prefecture(name: "群馬県", queryName: "Gunma"),
    Prefecture(name: "埼玉県", queryName: "Saitama"),
    Prefecture(name: "千葉県", queryName: "Chiba"),
    Prefecture(name: "東京都", queryName: "Tokyo"),
    Prefecture(name: "神奈川県", queryName: "Kanagawa"),
    Prefecture(name: "新潟県", queryName: "Niigata"),
    Prefecture(name: "富山県", queryName: "Toyama"),
    Prefecture(name: "石川県", queryName: "Ishikawa"),
    Prefecture(name: "福井県", queryName: "Fukui"),
    Prefecture(name: "山梨県", queryName: "Yamanashi"),
    Prefecture(name: "長野県", queryName: "Nagano"),
    Prefecture(name: "岐阜県", queryName: "Gifu"),
    Prefecture(name: "静岡県", queryName: "Shizuoka"),
    Prefecture(name: "愛知県", queryName: "Aichi"),
    Prefecture(name: "三重県", queryName: "Mie"),
    Prefecture(name: "滋賀県", queryName: "Shiga"),
    Prefecture(name: "京都府", queryName: "Kyoto"),
    Prefecture(name: "大阪府", queryName: "Osaka"),
    Prefecture(name: "兵庫県", queryName: "Hyogo"),
    Prefecture(name: "奈良県", queryName: "Nara"),
    Prefecture(name: "和歌山", queryName: "Wakayama"),
    Prefecture(name: "鳥取県", queryName: "Tottori"),
    Prefecture(name: "島根県", queryName: "Shimane"),
    Prefecture(name: "岡山県", queryName: "Okayama"),
    Prefecture(name: "広島県", queryName: "Hiroshima"),
    Prefecture(name: "山口県", queryName: "Yamaguchi"),
    Prefecture(name: "徳島県", queryName: "Tokushima"),
    Prefecture(name: "香川県", queryName: "Kagawa"),
    Prefecture(name: "愛媛県", queryName: "Ehime"),
    Prefecture(name: "高知県", queryName: "Kochi"),
    Prefecture(name: "福岡県", queryName: "Fukuoka"),
    Prefecture(name: "佐賀県", queryName: "Saga"),
    Prefecture(name: "長崎県", queryName: "Nagasaki"),
    Prefecture(name: "熊本県", queryName: "Kumamoto"),
    Prefecture(name: "大分県", queryName: "Oita"),
    Prefecture(name: "宮崎県", queryName: "Miyazaki"),
    Prefecture(name: "鹿児島県", queryName: "Kagoshima"),
    Prefecture(name: "沖縄県", queryName: "Okinawa")

]

let prefecture:[(name:String, queryName:String)] = [
    (name: "北海道", queryName: "Hokkaido"),
    (name: "青森県", queryName: "Aomori"),
    (name: "岩手県", queryName: "Iwate"),
    (name: "宮城県", queryName: "Miyagi"),
    (name: "秋田県", queryName: "Akita"),
    (name: "山形県", queryName: "Yamagata"),
    (name: "福島県", queryName: "Fukushima"),
    (name: "茨城県", queryName: "Ibaraki"),
    (name: "栃木県", queryName: "Tochigi"),
    (name: "群馬県", queryName: "Gunma"),
    (name: "埼玉県", queryName: "Saitama"),
    (name: "千葉県", queryName: "Chiba"),
    (name: "東京都", queryName: "Tokyo"),
    (name: "神奈川県", queryName: "Kanagawa"),
    (name: "新潟県", queryName: "Niigata"),
    (name: "富山県", queryName: "Toyama"),
    (name: "石川県", queryName: "Ishikawa"),
    (name: "福井県", queryName: "Fukui"),
    (name: "山梨県", queryName: "Yamanashi"),
    (name: "長野県", queryName: "Nagano"),
    (name: "岐阜県", queryName: "Gifu"),
    (name: "静岡県", queryName: "Shizuoka"),
    (name: "愛知県", queryName: "Aichi"),
    (name: "三重県", queryName: "Mie"),
    (name: "滋賀県", queryName: "Shiga"),
    (name: "京都府", queryName: "Kyoto"),
    (name: "大阪府", queryName: "Osaka"),
    (name: "兵庫県", queryName: "Hyogo"),
    (name: "奈良県", queryName: "Nara"),
    (name: "和歌山", queryName: "Wakayama"),
    (name: "鳥取県", queryName: "Tottori"),
    (name: "島根県", queryName: "Shimane"),
    (name: "岡山県", queryName: "Okayama"),
    (name: "広島県", queryName: "Hiroshima"),
    (name: "山口県", queryName: "Yamaguchi"),
    (name: "徳島県", queryName: "Tokushima"),
    (name: "香川県", queryName: "Kagawa"),
    (name: "愛媛県", queryName: "Ehime"),
    (name: "高知県", queryName: "Kochi"),
    (name: "福岡県", queryName: "Fukuoka"),
    (name: "佐賀県", queryName: "Saga"),
    (name: "長崎県", queryName: "Nagasaki"),
    (name: "熊本県", queryName: "Kumamoto"),
    (name: "大分県", queryName: "Oita"),
    (name: "宮崎県", queryName: "Miyazaki"),
    (name: "鹿児島県", queryName: "Kagoshima"),
    (name: "沖縄県", queryName: "Okinawa")
]
