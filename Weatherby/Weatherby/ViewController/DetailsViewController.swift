//
//  DetailsViewController.swift
//  Weatherby
//
//  Created by Reka Vihari on 2019. 02. 09..
//  Copyright © 2019. Reka Vihari. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class DetailsViewController: UIViewController {

    @IBOutlet weak var countryNameNavigationItem: UINavigationItem!

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var temperatureValueLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!

    @IBOutlet weak var maxTempValueLabel: UILabel!
    @IBOutlet weak var minTempValueLabel: UILabel!

    @IBOutlet weak var sunriseValueLabel: UILabel!
    @IBOutlet weak var sunsetValueLabel: UILabel!

    @IBOutlet weak var cloudCoverageValueLabel: UILabel!
    @IBOutlet weak var humidityValueLabel: UILabel!
    @IBOutlet weak var pressureValueLabel: UILabel!

    @IBOutlet weak var windSpeedValueLabel: UILabel!
    @IBOutlet weak var windDirectionValueLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!

    var location: Endpoints?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupDefaultLabels()

        let weatherService = WeatherService.shared
        guard let location = location else { return }
        weatherService.getWeather(for: location, completion: { weather in
            print(weather)
            self.setupLabels(with: weather)
            self.setIconImage(with: weather)
            self.configureMap(with: weather)

        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        configureView()
    }

    private func configureView() {
        navigationController?.navigationBar.barTintColor = UIColor(red:0.31, green:0.71, blue:0.98, alpha:1.0)
        navigationController?.navigationBar.addDropShadow(offSet: CGSize(width: 0, height: 1), radius: 10)
        navigationController?.navigationBar.topItem?.title = " "
        view.backgroundColor = UIColor.white

    }

    private func setupDefaultLabels() {
        iconImageView.image = nil
        countryNameNavigationItem.title = "-"
        temperatureValueLabel.text = "-"
        weatherLabel.text = "-"
        weatherDescriptionLabel.text = "-"
        maxTempValueLabel.text = "-"
        minTempValueLabel.text = "-"
        sunriseValueLabel.text = "-"
        sunsetValueLabel.text = "-"
        cloudCoverageValueLabel.text = "-"
        humidityValueLabel.text = "-"
        pressureValueLabel.text = "-"
        windSpeedValueLabel.text = "-"
        windDirectionValueLabel.text = "-"

    }

    private func setupLabels(with data: WeatherData) {
        self.countryNameNavigationItem.title = data.name
        self.temperatureValueLabel.text = String(inCelsius(temp: data.main.temp))+" °"
        self.weatherLabel.text = data.weather[0].main
        self.weatherDescriptionLabel.text = data.weather[0].description
        self.maxTempValueLabel.text = String(inCelsius(temp: data.main.tempMax))+" °"
        self.minTempValueLabel.text = String(inCelsius(temp: data.main.tempMin))+" °"
        self.sunriseValueLabel.text = setSunTime(temp: Double(data.sys.sunrise))
        self.sunsetValueLabel.text = setSunTime(temp: Double(data.sys.sunset))
        self.cloudCoverageValueLabel.text = String(data.clouds.all)+" %"
        self.humidityValueLabel.text = String(data.main.humidity)+" %"
        self.pressureValueLabel.text = String(data.main.pressure)+" hpa"
        self.windSpeedValueLabel.text = String(data.wind.speed)+" km/h"
        self.windDirectionValueLabel.text = String(data.wind.deg)+" °"

    }

    private func setIconImage(with data: WeatherData){
        let iconName = data.weather[0].icon
        let urlString = "http://openweathermap.org/img/w/"+"\(iconName)"+".png"
        guard let url = URL(string: urlString) else { return }
        iconImageView.kf.setImage(with: url)

    }

    private func inCelsius(temp: Double) -> Int {
        return Int(temp - 272.15)
        
    }

    private func setSunTime(temp: Double) -> String {
        let calendar = Calendar.current
        let sunDate = Date(timeIntervalSince1970: temp)
        let sunDateComponents = calendar.dateComponents([.hour, .minute], from: sunDate)
        guard let hour = sunDateComponents.hour else { return ""}
        guard let minute = sunDateComponents.minute else { return ""}
        if minute < 10 {
            return "\(hour):0\(minute)"
        }
        return "\(hour):\(minute)"

    }

    private func configureMap(with data: WeatherData) {
        mapView.layer.cornerRadius = 10
        let lat: CLLocationDegrees = data.coord.lat
        let long: CLLocationDegrees = data.coord.lon
        let span = MKCoordinateSpan(latitudeDelta: 0.075, longitudeDelta: 0.075)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: span)
        mapView.setRegion(region, animated: true)
        let artwork = MapPin(title: "\(data.name) \(inCelsius(temp:data.main.temp))°",
                             weatherName: "\(data.weather[0].main)",
                             coordinate: CLLocationCoordinate2D(latitude: data.coord.lat, longitude: data.coord.lon))
        mapView.addAnnotation(artwork)

    }

}

