//
//  Request.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/26.
//

import Moya

let appid = "5dfc577c1d7d94e9e23a00431582f1ac"

struct PrefectureWeatherRequest: APITargetType {
    typealias Response = WeatherModel
    var path: String { return "/weather" }
    var task: Task { return .requestParameters(parameters: ["q" : self.prefecture, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
    var prefecture: String
    init(prefecture: String) {
        self.prefecture = prefecture
    }
}

struct CurrentLocationWeatherRequest: APITargetType {
    typealias Response = WeatherModel
    var path: String { return "/weather" }
    var task: Task { return .requestParameters(parameters: ["lat" : self.coordinate.lat, "lon": self.coordinate.lon, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
    var coordinate: Coordinate
    init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
}

struct WeeklyCurrentLocationWeatherRequest: APITargetType {
    typealias Response = OneCallModel
    var path: String { return "/onecall" }
    var task: Task { return .requestParameters(parameters: ["lat" : self.coordinate.lat, "lon": self.coordinate.lon, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
    var coordinate: Coordinate
    init(coordinate: Coordinate) {
        self.coordinate = coordinate
    }
}
