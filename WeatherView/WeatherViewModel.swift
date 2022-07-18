//
//  WeatherViewModel.swift
//  weather
//
//  Created by Huan Le A. on 15/07/2022.
//

import Foundation
import Combine

enum WeatherViewModelState {
    case loading
    case finishedLoading
    case error(Error)
}

final class WeatherViewModel {
    
    @Published var searchText: String = "SaiGon"
    @Published private(set) var weatherInfo: WeatherObj?
    @Published private(set) var state: WeatherViewModelState = .loading
    
    private let weatherService: WeatherServiceProtocol
    private var bindings = Set<AnyCancellable>()
    private let searchResult = PassthroughSubject<Void, Error>()
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
        $searchText
            .sink { [weak self] in self?.searchWeather(with: $0) }
            .store(in: &bindings)
    }
    
    func getDateInWeak() -> [String] {
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 2 // Start on Monday (or 1 for Sunday)
        let today = calendar.startOfDay(for: Date())
        var week = [String]()
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: today) {
            for i in 0...6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    let format = DateFormatter()
                    format.dateFormat = "EEE, dd MMM yyyy"
                    week.append(format.string(from: day))
                }
            }
        }
        return week
    }
    
    func searchWeather(with searchTerm: String?) {
        if searchTerm?.count ?? 0 >= 3 {
            state = .loading
            self.weatherService.getWeather(city: searchTerm) { result in
                switch result {
                case .success( let weatherInfo):
                    self.weatherInfo = weatherInfo
                    self.searchResult.send()
                    self.state = .finishedLoading
                case .failure(let error):
                    self.weatherInfo?.list = []
                    self.searchResult.send(completion: .failure(error))
                    self.state = .error(error)
                    return
                }
            }
        }
    }
    
    func weatherViewModelForDetail(indexPath :IndexPath) -> WeatherDetailViewModel {
        let wheather = weatherInfo
        return WeatherDetailViewModel(weather: wheather!, indexPath: indexPath)
        
    }
    
}

