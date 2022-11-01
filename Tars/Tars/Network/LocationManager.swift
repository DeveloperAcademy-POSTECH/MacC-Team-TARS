//
//  LocationManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation
import CoreLocation

enum LocationError: Error {
    case currentLocationFailure
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let locationManager = CLLocationManager()
    private var location: CLLocation?
    private var isLocationUpdated: Bool = false

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isLocationUpdated {
            isLocationUpdated = true

            manager.stopUpdatingLocation()
            let location = locations[locations.count - 1]
            self.location = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error): \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .restricted, .denied:
            print("authorization restricted or denied")
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    func updateLocation() {
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func getCurrentLocation() -> (Double, Double, Double)? {
        guard let location = location else { return nil }
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        let altitude = location.altitude
        return (latitude, longtitude, altitude)
    }
}
