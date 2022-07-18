//
//  API.swift
//  weather
//
//  Created by Huan Le A. on 15/07/2022.
//

import Foundation
import Combine
import UIKit

let FORECAST_DAILY = "https://api.openweathermap.org/data/2.5/forecast/daily"
let API_KEY_NAME = "appid"
let CITY = "q"
let API_KEY_VALUE = "60c6fbeb4b93ac653c492ba806fc346d"
let CNT = "cnt"
let CNT_VALUE = "7"
let UNITS = "units"
let UNITS_VALUE = "metric"

struct API {
    enum APIError: Error {
        case error(String)
        case errorURL
        case invalidResponse
        case errorParsing
        case unknown
        
        var localizedDescription: String {
            switch self {
            case .error(let string):
                return string
            case .errorURL:
                return "URL String is error."
            case .invalidResponse:
                return "Invalid response"
            case .errorParsing:
                return "Failed parsing response from server"
            case .unknown:
                return "An unknown error occurred"
            }
        }
    }
}

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

protocol WeatherServiceProtocol {
    func getWeather(city: String?, _ promise: @escaping (Result<WeatherList, Error>) -> Void)
    func downloadIconWith(iconValue :String) -> UIImage
}

class WeatherService: WeatherServiceProtocol {
    func getWeather(city: String?, _ promise: @escaping ((Result<WeatherList, Error>) -> Void)){
        guard let urlRequest = self.getURLRequestByCity(city: city) else {
            promise(.failure(ServiceError.urlRequest))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data else {
                return
            }
            
            do {
                let parseJson = try JSONDecoder().decode(WeatherList.self, from: data)
                promise(.success(parseJson))
            } catch{
                promise(.failure(ServiceError.decode))
            }
        }.resume()
    }
    
    private func getURLRequestByCity(city: String?) -> URLRequest?{
        guard var urlComponents = URLComponents(string: FORECAST_DAILY) else {return nil}
        urlComponents.queryItems = [
            URLQueryItem(name: CITY, value: city),
            URLQueryItem(name: API_KEY_NAME, value: API_KEY_VALUE),
            URLQueryItem(name: CNT, value: CNT_VALUE),
            URLQueryItem(name: UNITS, value: UNITS_VALUE)]
        
        guard let url = urlComponents.url else {return nil}
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 5
        print("-- url: \(url)")
        return urlRequest
    }
    
    func downloadIconWith(iconValue :String) -> UIImage{
        guard let imageUrl = URL(string: ("https://openweathermap.org/img/wn/" + iconValue) + "@2x.png") else {
            return UIImage()
        }
        
        guard let imageData = try? Data(contentsOf: imageUrl) else {
            return UIImage()
        }
        return UIImage(data: imageData) ?? UIImage()
        
    }
    
}

