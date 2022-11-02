//
//  LocationManagerDelegate.swift
//  Tars
//
//  Created by 이윤영 on 2022/11/02.
//

import Foundation
import UIKit

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
