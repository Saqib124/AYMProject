//
//  WeatherViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, WeatherHandlerDelegate, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    // MARK: - IBOutlet
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureUnitLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windRateLabel: UILabel!
    @IBOutlet var weatherCollectionView: UICollectionView!
    
    // MARK: - Class variables
    let weatherHandler = WeatherAPIHandler()
    var weatherArray: [WeatherInfo] = []
    var userLocation:CLLocationCoordinate2D?
    
    // MARK: - controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather broadcast"
        weatherHandler.delegate = self
        weatherHandler.getResultsFromAPI(location: userLocation!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 250/255, green: 217/255, blue: 180/255, alpha: 1.0)
        
        let numberOfCell: CGFloat = 5   //you need to give a type as CGFloat
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cellWidth/numberOfCell, height: cellWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        weatherCollectionView!.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpView()
    {
        let weather = weatherArray[0]
        cityLabel.text = weather.city
        dayLabel.text = weather.day
        conditionLabel.text = weather.condition
        temperatureLabel.text = weather.temperature
        temperatureUnitLabel.text = weather.temperatureUnit == unit.celsius ? "°C" : "°K"
        humidityLabel.text = weather.humidity
        windRateLabel.text = weather.windRate
        weatherImage.image = UIImage(named: weather.weatherImage)!
        
    }
    

    @objc func addTapped() {
        weatherHandler.getResultsFromAPI(location: userLocation!)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Collectionview delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherArray.count > 6 ? 5 : weatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! forecastCell
        let weather = self.weatherArray[indexPath.row + 1]
        cell.configure(weather: weather)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCell: CGFloat = 5   //you need to give a type as CGFloat
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        return CGSize(width: cellWidth, height: 107)
    }

}
