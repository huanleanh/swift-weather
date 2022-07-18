//
//  WeatherDetailViewModel.swift
//  weather
//
//  Created by Huan Le A. on 18/07/2022.
//

import Foundation
import Combine
import UIKit

class WeatherDetailViewModel {
    var weather: WeatherObj!
    var indexPath: IndexPath
    private var cancelable = [AnyCancellable]()
    var downloadedSuccess = PassthroughSubject<UIImage?, Never>()

    init(weather: WeatherObj, indexPath: IndexPath) {
        self.weather = weather
        self.indexPath = indexPath
    }

    deinit {
    }
}
