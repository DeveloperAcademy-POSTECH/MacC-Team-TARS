//
//  InfoViewController.swift
//  Tars
//
//  Created by Ayden on 2022/10/24.
//

import UIKit

class InfoViewController: UIViewController {
    lazy var planetImageView: UIImageView = {
        let planetImage = UIImageView()
        planetImage.image = UIImage(named: "jupiter")
        planetImage.contentMode = .scaleAspectFill
        return planetImage
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(planetImageView)
        configureConstraints()
    }
    
    private func configureConstraints() {
        planetImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            planetImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            planetImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40)
            
        ])
    }
}
