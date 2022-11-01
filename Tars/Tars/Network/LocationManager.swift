//
//  LocationManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation
import CoreLocation
import UIKit

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

protocol LocationManagerDelegate: AnyObject, UIViewController {
    func didUpdateUserLocation()
}

extension LocationManagerDelegate {
    // TODO: - 임시로 설정한 message 변경
    func openSetting() {
        let alert = UIAlertController(title: "위치 서비스 사용", message: "위치서비스를 사용할 수 없습니다. 기기의 설정 > SpaceOver > 위치에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "설정으로 이동", style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        })
        let destructiveAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(destructiveAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
