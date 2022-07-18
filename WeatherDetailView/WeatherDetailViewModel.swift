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
    var weather: WeatherList!
    var indexPath: IndexPath
    private var cancelable = [AnyCancellable]()
    var downloadedSuccess = PassthroughSubject<UIImage?, Never>()

    init(weather: WeatherList, indexPath: IndexPath) {
        self.weather = weather
        self.indexPath = indexPath
    }

//    func downloadImage() {
//        WeatherService.downloadIconWith(self.weather.list[])(imageUrl: movie.backgroundUrl ?? "")
//            .sink { [weak self] complete in
//                switch complete {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print("download detail background Image error: \(error.localizedDescription)")
//                    self?.downloadedSuccess.send(nil)
//                }
//            } receiveValue: { [weak self] image in
//                print("download detail background success")
//                self?.movie.backgroundImage = image
//                self?.downloadedSuccess.send(image)
//            }
//            .store(in: &cancelable)
//    }

    deinit {
    }
}
