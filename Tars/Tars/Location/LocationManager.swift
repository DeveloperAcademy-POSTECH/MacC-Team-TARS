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
    weak var delegate: LocationManagerDelegate?

    private let locationManager = CLLocationManager()
    private var location: CLLocation?
    private var isLocationUpdated: Bool = false

    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isLocationUpdated {
            isLocationUpdated = true

            manager.stopUpdatingLocation()
            let location = locations[locations.count - 1]
            self.location = location
            
            didUpdateUserLocation()
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
            openSetting()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
    
    // MARK: - LocationManager method

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
    
    private func didUpdateUserLocation() {
        guard let delegate = delegate else { return }
        delegate.didUpdateUserLocation()
    }
    
    private func openSetting() {
        guard let delegate = delegate else { return }
        delegate.openSetting()

    }
}
