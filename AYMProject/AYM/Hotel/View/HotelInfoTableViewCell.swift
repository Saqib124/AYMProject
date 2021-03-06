//
//  HotelInfoTableViewCell.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit

class HotelInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var perviewImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var rateView: RateStarView!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    func configure(hotel: HotelInfo) {
        nameLabel.text = hotel.name
        locationLabel.text = hotel.location
        typeLabel.text = hotel.type
        viewsLabel.text = "\(hotel.noOfView) views"
        perviewImage.imageFromServerURL(urlString: hotel.imageUrl)
        rateView.rating = Int(hotel.rating)
        rateLabel.text = String(format: "%d", hotel.rating)
    }
    
}
