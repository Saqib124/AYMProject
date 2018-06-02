//
//  WeatherViewController.swift
//  AYMProject
//
//  Created by Muhammad Saqib Khan on 6/1/18.
//  Copyright © 2018 Muhammad Saqib Khan. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

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
        weatherHandler.delegate = self as WeatherHandlerDelegate
        weatherHandler.getResultsFromAPI(location: userLocation!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(addTapped))
        navigationController?.navigationBar.barTintColor = UIColor.init(red: 250/255, green: 217/255, blue: 180/255, alpha: 1.0)
        setupCollectionView()
    }
    
    func setUpView(){
        let weather = weatherArray[0]
        cityLabel.text = weather.city
        dayLabel.text = weather.day
        conditionLabel.text = weather.condition
        temperatureLabel.text = weather.temperature
        temperatureUnitLabel.text = weather.temperatureUnit == Unit.celsius ? "°C" : "°K"
        humidityLabel.text = weather.humidity
        windRateLabel.text = weather.windRate
        weatherImage.image = UIImage(named: weather.weatherImage)!
        
    }
    
    @objc func addTapped() {
        weatherHandler.getResultsFromAPI(location: userLocation!)
    }
}


// MARK: Extension for weather handler delegate
extension WeatherViewController: WeatherHandlerDelegate {
    
    func getTheWeather(array: Array<WeatherInfo>){
        if array.count == 0 {
            let alert = UIAlertController(title: "Alert", message: "Array count is zero", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.weatherArray = array;
        self.weatherCollectionView.reloadData()
        setUpView()
    }
    
    func errorInFetchingWeather(error: Error){
        let alert = UIAlertController(title: "Error Alert", message: "Error in fetching the records, please refresh the screen", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


// MARK: Extension for colletionView delegate
extension WeatherViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView(){
        let numberOfCell: CGFloat = 5   //you need to give a type as CGFloat
        let cellWidth = UIScreen.main.bounds.size.width / numberOfCell
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cellWidth/numberOfCell, height: cellWidth)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        weatherCollectionView!.collectionViewLayout = layout
    }
    
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

