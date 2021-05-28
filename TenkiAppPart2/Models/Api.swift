//
//  APi.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Moya

class APIService {}

protocol APITargetType: TargetType {
}

extension APITargetType {
    var method: Moya.Method { return .get }
    var baseURL: URL { return URL(string: "https://api.openweathermap.org/data/2.5/")! }
    var headers: [String : String]? { return ["Content-Type": "application/json"] }
    var sampleData: Data { return Data() }
}
