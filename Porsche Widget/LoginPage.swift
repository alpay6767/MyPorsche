//
//  LoginPage.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 19.09.22.
//

import Foundation
import UIKit
import PorscheConnect

class LoginPage: UIViewController {
    
    @IBOutlet weak var email_textfield: UITextField!
    @IBOutlet weak var password_textfield: UITextField!
    
    var porscheConnect: PorscheConnect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func login(_ sender: Any)  {
        porscheConnect = PorscheConnect(username: email_textfield.text!,
                                            password: password_textfield.text!)
        
        print("logging in!")
        Task {
                try await getVehicles()
        }
        
    }
    
    
    @IBAction func perform_forgot_email(_ sender: Any) {
    }
    
    
    @IBAction func perform_forgot_password(_ sender: Any) {
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    func getVehicles() async {
        do {
            let result = try! await porscheConnect!.vehicles()
            if let vehicles = result.vehicles, let response = result.response {
            // Do something with vehicles or raw response
                Home.porscheManager = PorscheManager(selectedPorsche: vehicles[0])
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "homenavigationcontroller")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
          }
        } catch let error{
          // Handle the error
            print(error)
        }
    }
    
}
