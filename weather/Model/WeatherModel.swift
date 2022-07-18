//
//  NameModel.swift
//  weather
//
//  Created by Huan Le A. on 13/07/2022.
//

import Foundation


struct WeatherObj: Codable {
    var list: [Weather]
    var city: City
}

struct City: Codable {
    var name: String
    var coord: Coord
}

struct Coord: Codable {
    var lat: Double
    var lon: Double
}


struct Weather: Codable {
    var temp: TempDetail
    var pressure: Int
    var humidity: Int
    var weather: [WeatherDetail]
}

struct WeatherDetail: Codable {
    var main: String
    var description: String
    var icon: String
}

struct TempDetail: Codable {
    var min: Double
    var max: Double
}
