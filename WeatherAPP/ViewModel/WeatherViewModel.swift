//
//  WeatherViewModel.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine
import CoreLocation


final class WeatherViewModel: ObservableObject {
    @Published var model: [WeatherResponse] = []
    var cityName: String = ""
    @Published var viewData = [LocalSearchViewData]()
    var locationManager = LocationManager(center: CLLocationCoordinate2D(latitude: 40.730610, longitude: -73.935242))
    private var cancellableData: AnyCancellable?
    private var locationCancellable: AnyCancellable?
    @Published var cityText = "" {
        didSet {
            searchForCity(text: cityText)
        }
    }
    
    init() {
        locationManager.startUpdating()
        locationManager.callback = getLocation
        locationCancellable = locationManager.localSearchPublisher.sink(receiveValue: {[weak self] values in
            self?.viewData = values.map({ LocalSearchViewData(mapItem: $0) })
        })
    }
    
    private func getLocation(_ location: CLLocation?, name: String?) {
        self.cityName = name ?? "Munich"
        getWeather(lat: CGFloat(location?.coordinate.latitude ?? 0), long: CGFloat(location?.coordinate.longitude ?? 0))
    }
    
    private func getWeather(lat: CGFloat, long: CGFloat) {
        cancellableData = APIManager<WeatherResponse>.shared.request(.getWeather(lat: lat, long: long)).mapError({ (error) -> Error in
            print(error)
            return error
        })
        .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] in
            self?.model = [$0]
        }) 
        
    }
    
    private func searchForCity(text: String) {
        locationManager.searchCities(searchText: text)
    }
    
    
    deinit {
        cancellableData = nil
        locationCancellable = nil
    }
    
    func calculateCelsius(fahrenheit: Double) -> Double {
        let fahrenheitTemp = Measurement(value: fahrenheit, unit: UnitTemperature.fahrenheit)
        let celciusTemp = fahrenheitTemp.converted(to: .celsius).value
        
        return celciusTemp
    }
}



