//
//  WeatherDetailViewController.swift
//  weather
//
//  Created by Huan Le A. on 18/07/2022.
//

import Foundation
import UIKit
import Combine

class WeatherDetailViewController: UIViewController {
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak private var minDeg: UILabel!
    @IBOutlet weak private var maxDeg: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    
    var viewModel: WeatherDetailViewModel!
    private var cancelable = [AnyCancellable]()
    var weatherService: WeatherServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService = WeatherService()
        setUpView()
    }
    
    private func setUpView() {
        let index = self.viewModel.indexPath.row
        let list = self.viewModel.weather.list
        self.minDeg.text = list[index].temp.min.description
        self.maxDeg.text = list[index].temp.max.description
        self.descriptionLbl.text = list[index].weather[0].description.description
        self.weatherIcon.image = weatherService?.downloadIconWith(iconValue: list[index].weather[0].icon.description)
    }
    
}
