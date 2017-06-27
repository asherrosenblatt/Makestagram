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
        super.init()
    }
    
    init?(snapshot: DataSnapshot)
    {
        guard let dict = snapshot.value as? [String : Any],
            let username = dict["username"] as? String
            else { return nil }
        
        self.uid = snapshot.key
        self.username = username
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        guard let uid = aDecoder.decodeObject(forKey: Constants.UserDefaults.uid) as? String,
            let username = aDecoder.decodeObject(forKey: Constants.UserDefaults.username) as? String
            else { return nil }
        
        self.uid = uid
        self.username = username
        super.init()
    }
    
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false)
    {
        if writeToUserDefaults
        {
            let data = NSKeyedArchiver.archivedData(withRootObject: user)
            UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
        }
        _current = user
    }

}

extension User: NSCoding
{
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(uid, forKey: Constants.UserDefaults.uid)
        aCoder.encode(username, forKey: Constants.UserDefaults.username)
    }
}
