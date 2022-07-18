//
//  CityViewCell.swift
//  weather
//
//  Created by Huan Le A. on 13/07/2022.
//

import UIKit

class CityViewCell: UITableViewCell {
    @IBOutlet weak private var minDegLbl: UILabel!
    @IBOutlet weak private var maxDegLbl: UILabel!
    @IBOutlet weak private var descriptionLbl: UILabel!
    @IBOutlet weak private var humidityLbl: UILabel!
    @IBOutlet weak private var cityNameLbl: UILabel!
    @IBOutlet weak private var weatherImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    
    private var weatherService: WeatherServiceProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weatherService = WeatherService()
    }
    
    func loadWheatherIconFrom(iconValue: String?) {
        DispatchQueue.main.async {
            self.weatherImg.image = self.weatherService?.downloadIconWith(iconValue: iconValue ?? "")
        }
    }
    
    func setDate(date: String) {
        dateLbl.text = date
    }
    
    func updateUIValue(name: String, value: String?) {
        switch name {
        case "min": minDegLbl.text = value ?? "" + "˚C"
        case "max": maxDegLbl.text = value ?? "" + "˚C"
        case "humidity": humidityLbl.text = value ?? "" + "%"
        case "description": descriptionLbl.text = value ?? ""
        case "cityName": cityNameLbl.text = value ?? ""
        default:
            return
        }
    }
}

