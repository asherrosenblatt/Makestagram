//
//  User.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/26/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: NSObject
{
    // MARK: - Singleton
    private static var _current: User?
    
    static var current: User
    {
        guard let currentUser = _current else { fatalError("Error: current user doesnt exist") }
        return currentUser
    }
    
    // MARK: - Properties
    
    let uid: String
    let username: String
    
    // MARK: - Implementation
    
    init(uid: String, username: String)
    {
        self.uid = uid
        self.username = username
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
    }
    
    static func setCurrent(_ user: User)
    {
        _current = user
    }
}
