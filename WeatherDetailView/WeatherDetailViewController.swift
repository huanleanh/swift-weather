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
    @IBOutlet weak private var weatherImg: UIImageView!
    @IBOutlet weak private var minDegLbl: UILabel!
    @IBOutlet weak private var maxDegLbl: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    
    var viewModel: WeatherDetailViewModel!
    private var cancelable = [AnyCancellable]()
    private var weatherService: WeatherServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherService = WeatherService()
        setUpView()
    }
    
    private func setUpView() {
        let index = self.viewModel.indexPath.row
        let list = self.viewModel.weather.list
        self.minDegLbl.text = list[index].temp.min.description
        self.maxDegLbl.text = list[index].temp.max.description
        self.descriptionLbl.text = list[index].weather[0].description.description
        self.weatherImg.image = weatherService?.downloadIconWith(iconValue: list[index].weather[0].icon.description)
    }
    
}
