//
//  CityViewCell.swift
//  weather
//
//  Created by Huan Le A. on 13/07/2022.
//

import UIKit

class CityViewCell: UITableViewCell {
    @IBOutlet weak private var MinDeg: UILabel!
    @IBOutlet weak private var MaxDeg: UILabel!
    @IBOutlet weak private var Description: UILabel!
    @IBOutlet weak private var Humidity: UILabel!
    @IBOutlet weak private var CityName: UILabel!
    @IBOutlet weak private var weatherIcon: UIImageView!
    @IBOutlet weak var DateText: UILabel!
    
    private var weatherService: WeatherServiceProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weatherService = WeatherService()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
    
    func loadWheatherIconFrom(iconValue: String?) {
        DispatchQueue.main.async {
            self.weatherIcon.image = self.weatherService?.downloadIconWith(iconValue: iconValue ?? "")
        }
    }
    
    func setDate(date: String) {
        DateText.text = date
    }
    
    func updateUIValue(name: String, value: String?) {
        switch name {
        case "min": MinDeg.text = value ?? "" + "˚C"
        case "max": MaxDeg.text = value ?? "" + "˚C"
        case "humidity": Humidity.text = value ?? "" + "%"
        case "description": Description.text = value ?? ""
        case "cityName": CityName.text = value ?? ""
        default:
            return
        }
    }
}

