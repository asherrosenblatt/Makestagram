//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/26/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController
{
    //HASH: properties
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!

    //HASH: implementation
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onnextButtonPressed(_ sender: Any)
    {
        // 1
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else {return}
            
            User.setCurrent(user, writeToUserDefaults: true)
            
            print("Created a new user \(user.username)")
            
            let initialViewController = UIStoryboard.initialViewController(for: .main)
            self.view.window?.rootViewController = initialViewController
            self.view.window?.makeKeyAndVisible()
        }
    }
}
