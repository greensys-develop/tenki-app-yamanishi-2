//
//  WeeklyCurrentLocationWeatherRequest.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/31.
//

import Moya

extension WeatherAPIService {
    struct WeeklyCurrentLocationWeatherRequest: APITargetType {
        typealias Response = OneCallModel
        var path: String { return "/onecall" }
        var task: Task { return .requestParameters(parameters: ["lat" : self.coordinate.lat, "lon": self.coordinate.lon, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
        var coordinate: Coordinate
        init(coordinate: Coordinate) {
            self.coordinate = coordinate
        }
    }
}
