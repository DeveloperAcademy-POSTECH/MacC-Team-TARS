//
//  LocationManagerDelegate.swift
//  Tars
//
//  Created by 이윤영 on 2022/11/02.
//

import UIKit

protocol LocationManagerDelegate: AnyObject, UIViewController {
    func didUpdateUserLocation()
}

extension LocationManagerDelegate {
    func openSetting() {
        let alert = UIAlertController(title: LocalizableKeys.locationUsageMessage.localized,
                                      message: LocalizableKeys.locationAuthRequest.localized,
                                      preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: LocalizableKeys.defaultAction.localized, style: .default, handler: { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        })
        let destructiveAction = UIAlertAction(title: LocalizableKeys.cancel.localized, style: .destructive, handler: nil)
        
        alert.addAction(destructiveAction)
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
