//
//  LocationManager.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/26.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    static let shared = LocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate{
    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:
                         [CLLocation]){
        guard let locations = locations.first else { return }
        self.userLocation = locations.coordinate
        locationManager.stopUpdatingLocation()
    }
}
