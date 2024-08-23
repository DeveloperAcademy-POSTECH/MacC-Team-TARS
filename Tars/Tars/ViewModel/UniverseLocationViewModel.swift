//
//  UniverseLocationViewModel.swift
//  Tars
//
//  Created by Lena on 2024/8/2.
//

import Foundation
import AVFoundation
import CoreLocation
import Combine

class UniverseLocationViewModel: NSObject, ObservableObject {
    private let locationManager = LocationManager.shared
    @Published var currentLocation: CLLocation?
    @Published var isAuthorized: Bool = false
    @Published var showSettingAlert: Bool = false
    @Published var showErrorAlert: Bool?
    @Published var bodies: [Body] = []

    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        bindToSettingAlert()
        bindToLocationUpdates()
    }
    
    func bindToLocationUpdates() {
        locationManager.$location
            .sink { [weak self] location in
                self?.currentLocation = location
                self?.handleLocationUpdate()
            }
            .store(in: &cancellables)
    }
    
    func bindToSettingAlert() {
        locationManager.$needsSettingAlert
            .sink { [weak self] needsAlert in
                if needsAlert {
                    self?.showSettingAlert = true
                }
            }
            .store(in: &cancellables)
    }
    
    func updateLocation() {
        locationManager.updateLocation()
    }
    
    func updateAuthorizationStatus() -> Bool {
        let locationStatus = CLLocationManager.authorizationStatus()
        let cameraStatus = AVCaptureDevice.authorizationStatus(for: .video)
        
        return (locationStatus == .authorizedAlways || locationStatus == .authorizedWhenInUse) && cameraStatus == .authorized
    }
    
    private func handleLocationUpdate() {
        guard let location = currentLocation else { return }
        
        Task {
            do {
                let bodies = try await HorizonsAPIManager().requestBodies()
                self.bodies = bodies
                showErrorAlert = false
            } catch {
                print("Failed to fetch bodies: \(error.localizedDescription)")
                showErrorAlert = true
            }
        }
    }
}
