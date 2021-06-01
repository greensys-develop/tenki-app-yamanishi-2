//
//  Request.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Moya

extension WeatherAPIService {
    struct PrefectureWeatherRequest: APITargetType {
        typealias Response = WeatherModel
        var path: String { return "/weather" }
        var task: Task { return .requestParameters(parameters: ["q" : self.prefecture, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
        var prefecture: String
        init(prefecture: String) {
            self.prefecture = prefecture
        }
    }
}
