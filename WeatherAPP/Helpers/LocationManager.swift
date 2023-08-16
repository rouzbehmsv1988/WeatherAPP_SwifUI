//
//  LocationManager.swift
//  WeatherAPP
//
//  Created by rouzbeh on 01.08.23.
//

import Foundation
import CoreLocation
import MapKit
import Combine

//Response type of MAPKit search
struct LocalSearchViewData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    
    init(mapItem: MKMapItem) {
        self.title = mapItem.name ?? ""
        self.subtitle = mapItem.placemark.title ?? ""
    }
}

// MARK: location delegates
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let localSearchPublisher = PassthroughSubject<[MKMapItem], Never>()
    private let center: CLLocationCoordinate2D
    private let radius: CLLocationDistance
    private let manager = CLLocationManager()
    var lastKnownLocation: CLLocation?
    var callback: ((CLLocation?, String?)->())?
    init(lastKnownLocation: CLLocation? = nil, center: CLLocationCoordinate2D,
         radius: CLLocationDistance = 400_000) {
        self.lastKnownLocation = lastKnownLocation
        self.center = center
        self.radius = radius
    }

    func startUpdating() {
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLoc = locations.last else { return }
        lastKnownLocation = lastLoc
        let geocoder = CLGeocoder()
        // gets the name of the city based on location coordinates
        geocoder.reverseGeocodeLocation(lastLoc) { [weak self] (placemarks, error) in
            if error == nil {
                if let firstLocation = placemarks?[0],
                    let cityName = firstLocation.locality {
                    self?.callback?(locations.last, cityName)
                }
            }
        }
       
    }
    
    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    
}


extension LocationManager {
    
     func searchCities(searchText: String) {
        request(resultType: .address, searchText: searchText)
    }
    // search query on MAPKit
    private func request(resultType: MKLocalSearch.ResultType = .address,
                         searchText: String) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = resultType
        request.region = MKCoordinateRegion(center: center,
                                            latitudinalMeters: radius,
                                            longitudinalMeters: radius)
        let search = MKLocalSearch(request: request)

        search.start { [weak self](response, _) in
            guard let response = response else {
                return
            }

            self?.localSearchPublisher.send(response.mapItems)
        }
    }
}

