//
//  ContentsViewController.swift
//  Tars
//
//  Created by 김소현 on 2022/10/25.
//

import UIKit

class ContentsViewController: UIViewController {
    // TODO: ContentsViewController ==> InfoViewController
    
    public var planet: Planet =  Planet(planetName: "default", planetImage: UIImage(named: "default"))
    
    func setPlanet(name: String, image: UIImage) {
        planet = Planet(planetName: name, planetImage: image)
    }
    
    let planetImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "default")
        imageView.sizeToFit()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(planetImageView)

        planetImageView.anchor(top: view.topAnchor, paddingTop: 150)
        planetImageView.centerX(inView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        planetImageView.image = planet.planetImage
    }
}
