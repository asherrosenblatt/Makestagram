//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/26/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase
typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController, FUIAuthDelegate
{

    @IBOutlet weak var registerOrLoginButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?)
    {
        if let error = error
        {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
            
        guard let user = user
            else { return }
        
        UserService.show(forUID: user.uid)
        { (user) in
            if let user = user
            {
                //existing user login
                User.setCurrent(user)
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
            else
            {
                //new user. show username page
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
        
    }
    
    @IBAction func onRegisterOrLoginPressed(_ sender: Any)
    {
        guard let authUI = FUIAuth.defaultAuthUI()
            else {return}
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }

}
