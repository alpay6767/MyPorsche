//
//  Home.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 23.09.22.
//

import Foundation
import UIKit
import SkeletonView
import Kingfisher
import WidgetKit

class Home: UIViewController {
    
    @IBOutlet weak var car_name: UILabel!
    @IBOutlet weak var car_image: UIImageView!
    @IBOutlet weak var car_vin: UILabel!
    @IBOutlet weak var lock_button: UIButton!
    @IBOutlet weak var fan_button: UIButton!
    @IBOutlet weak var emobility_button: UIButton!
    @IBOutlet weak var quick_actios_view: UIStackView!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var actions_container_view: UIView!
    public static var porscheManager = PorscheManager()
    
    var porscheConnect: PorscheConnect?
    let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)
    let gradient = SkeletonGradient(baseColor: UIColor.clouds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImage()
        
        car_name.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        car_image.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        car_vin.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        quick_actios_view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        actions_container_view.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation)
        
        porscheConnect = PorscheConnect(username: (Home.porscheManager.currentUser?.email)!,
                                        password: (Home.porscheManager.currentUser?.password)!)
        
        Task {
            try await getVehicles()
            try await getVehicleCapabilities()
        }
        
        
    }
    
    func setAsWidget() {
        let defaults = UserDefaults(suiteName: "group.myporsche")
        defaults!.set(Home.porscheManager.vehicles![0].pictures![3].url, forKey: "selectedWidget")
        defaults?.synchronize()
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func addNavBarImage() {

        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))

         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 40))
         imageView.contentMode = .scaleAspectFit
         let image = #imageLiteral(resourceName: "porsche_splash_logo_dark")
         imageView.image = image
         logoContainer.addSubview(imageView)
         navigationItem.titleView = logoContainer
    }
    
    
    func getVehicles() async throws {
        do {
            let result = try await porscheConnect!.vehicles()
            if let vehicles = result.vehicles, let response = result.response {
            // Do something with vehicles or raw response
                Home.porscheManager.vehicles = vehicles
                car_name.text = "Porsche " + Home.porscheManager.vehicles![0].modelDescription
                car_vin.text = Home.porscheManager.vehicles![0].vin
                car_image.kf.setImage(with: Home.porscheManager.vehicles![0].pictures![0].url)
                setAsWidget()
                self.scrollView.hideSkeleton()
                //self.view.hideSkeleton()
          }
        } catch{
            print("Unexpected error: \(error).")
        }
    }
    
    func getVehicleCapabilities() async throws {
        do {
            let result = try await porscheConnect!.capabilities(vehicle: Home.porscheManager.vehicles![0])
            if let capabilities = result.capabilities, let response = result.response {
            // Do something with vehicles or raw response
                Home.porscheManager.capabilities = capabilities
                print(capabilities)
          }
        } catch{
            print("Unexpected error: \(error).")
        }
    }
}
