//
//  SplashscreenPage.swift
//  Porsche Widget
//
//  Created by Alpay Kücük on 13.10.22.
//

import Foundation
import UIKit
import RevealingSplashView


class SplashscreenPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
        let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "porsche_splash_logo_dark")!, iconInitialSize: CGSize(width: 167, height: 84), backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))

        //revealingSplashView.heartAttack = true
       
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)

        //Starts animation
        revealingSplashView.startAnimation(){
            
            let defaults = UserDefaults.standard
            let loggedIn = defaults.bool(forKey: "LoggedIn")
            
            
            if(loggedIn) {
                Home.porscheManager.currentUser = AppDelegate.getUserFromDefaults()
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "homenavigationcontroller")
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
            } else {
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "viewcontrollerpage") as! ViewController
                newViewController.modalPresentationStyle = .fullScreen
                self.present(newViewController, animated: true, completion: nil)
                
            }
            
        }

    }
    
    
}

