//
//  Home.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 23.09.22.
//

import Foundation
import UIKit

class Home: UIViewController {
    
    @IBOutlet weak var profile_image: UIImageView!
    @IBOutlet weak var car_name: UILabel!
    @IBOutlet weak var car_image: UIImageView!
    @IBOutlet weak var car_vin: UILabel!
    public static var porscheManager: PorscheManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile_image.layer.cornerRadius = profile_image.bounds.width/2
        profile_image.clipsToBounds = true
        car_name.text = "Porsche " + Home.porscheManager!.selectedPorsche.modelDescription
        car_vin.text = Home.porscheManager!.selectedPorsche.vin
        
    }
}
