//
//  LocationManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager = CLLocationManager()
    var location = CLLocation()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error): \(error.localizedDescription)")
    }
    
    func getCurrentLocation() -> (Double, Double, Double)? {
        locationManager.requestLocation()
        guard let location = locationManager.location else { return nil }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        let altitude = location.altitude
        return (latitude, longtitude, altitude)
    }
}
