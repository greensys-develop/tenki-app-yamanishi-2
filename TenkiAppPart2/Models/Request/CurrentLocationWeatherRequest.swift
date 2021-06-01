//
//  CurrentLocationWeatherRequest.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/31.
//

import Moya

extension WeatherAPIService {
    struct CurrentLocationWeatherRequest: APITargetType {
        typealias Response = WeatherModel
        var path: String { return "/weather" }
        var task: Task { return .requestParameters(parameters: ["lat" : self.coordinate.lat, "lon": self.coordinate.lon, "lang": "ja", "APPID": appid], encoding: URLEncoding.default) }
        var coordinate: Coordinate
        init(coordinate: Coordinate) {
            self.coordinate = coordinate
        }
    }
}
