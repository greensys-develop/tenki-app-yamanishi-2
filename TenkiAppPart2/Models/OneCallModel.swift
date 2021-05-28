//
//  OneCallModel.swift
//  TenkiAppPart2
//
//  Created by Mayumi Yamanishi on 2021/05/27.
//

import Foundation

struct OneCallModel: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezone_offset: Int
    let current: Current
    let minutely: [Minutely]
    let hourly: [Hourly]
    let daily: [Daily]?
}

struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let hourly: [Hourly]?
    let daily: [Daily]?
}

struct Minutely: Codable {
    let dt: Int
    let precipitation: Int
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let visibility: Int
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [Weather]
}

struct Daily: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moon_phase: Double
    let temp: Temp
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let wind_speed: Double
    let wind_deg: Int
    let wind_gust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Double
    let rain: Double?
    let uvi: Double
    
    init(dt: Int, sunrise: Int, sunset: Int, moonrise: Int, moon_phase: Double, temp: Temp, pressure: Int, humidity: Int, dew_point: Double, wind_speed: Double, wind_deg: Int, wind_gust: Double, weather: [Weather], clouds: Int, pop: Double, rain: Double?, uvi: Double) {
        self.dt = dt
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moon_phase = moon_phase
        self.temp = temp
        self.pressure = pressure
        self.humidity = humidity
        self.dew_point = dew_point
        self.wind_speed = wind_speed
        self.wind_deg = wind_deg
        self.wind_gust = wind_gust
        self.weather = weather
        self.clouds = clouds
        self.pop = pop
        self.rain = rain
        self.uvi = uvi
    }
}

struct Temp: Codable {
    let day: Double
    let min: Double
    let max: Double
    let night: Double
    let eve: Double
    let morn: Double
    let feels_like: [FeelsLike]?
}

struct FeelsLike: Codable {
    let day: Double
    let night: Double
    let eve: Double
    let morn: Double
}
