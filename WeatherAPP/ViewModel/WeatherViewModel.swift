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
    var newDataLoaded = false
    var workItem: DispatchWorkItem?
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
        guard let name = name else { return }
        self.cityName = name
        getWeather(cityName: name)
    }
    
    private func getWeather(cityName: String) {
        cancellableData = APIManager<WeatherResponse>.shared.request(.forcaste(cityName: cityName, numberOfDays: 10)).mapError({ (error) -> Error in
            print(error)
            return error
        })
        .sink(receiveCompletion: { _ in },
              receiveValue: { [weak self] in
            self?.newDataLoaded = true
            print($0)
            self?.model = [$0]
        }) 
        
    }
    
    func searchCity(name: String) {
        newDataLoaded = false
        locationManager.getCoordinateFrom(address: name) { [weak self] coordinate, error in
            guard let coord = coordinate else { return }
            self?.getLocation(CLLocation (latitude: coord.latitude, longitude: coord.longitude), name: name)
       
        }
    }
    
    private func searchForCity(text: String) {
        workItem?.cancel()
        let task  =  DispatchWorkItem { [weak self] in
            self?.locationManager.searchCities(searchText: text)
        }
        workItem = task
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5, execute: task)
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



