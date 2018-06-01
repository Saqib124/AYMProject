//
//  forecastCell.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/2/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

class forecastCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var perviewImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func configure(weather: WeatherInfo) {
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = UIColor.darkGray.cgColor
        dayLabel.text = weather.day
        temperatureLabel.text = "\(weather.temperature) °C"
        print(weather.weatherImage)
        perviewImage.image = UIImage(named: weather.weatherImage)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
