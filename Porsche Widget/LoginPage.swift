//
//  LoginPage.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 19.09.22.
//

import Foundation
import UIKit

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
    
        Home.porscheManager.currentUser = User(email: email_textfield.text!, password: password_textfield.text!)
        
        Task {
            try await executeLogin()
        }
        
        
    }
    
    
    @IBAction func perform_forgot_email(_ sender: Any) {
    }
    
    
    @IBAction func perform_forgot_password(_ sender: Any) {
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func executeLogin() async throws {
        
        do {
            //try await porscheConnect!.authIfRequired(application: application)
            AppDelegate.saveUserInDefaults(currentUser: (Home.porscheManager.currentUser!))
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homenavigationcontroller")
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        catch {
           print("Unexpected error: \(error).")
       }
    }
    
    
    func getVehicles() async throws{
        do {
            let result = try await porscheConnect!.vehicles()
            if let vehicles = result.vehicles {
            // Do something with vehicles or raw response
                Home.porscheManager.vehicles = vehicles
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "homenavigationcontroller")
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
          }
        } catch{
            print("Unexpected error: \(error).")
        }
    }
    
}
