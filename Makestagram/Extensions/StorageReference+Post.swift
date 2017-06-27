//
//  StorageReference+Post.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference
{
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference
    {
        let uid = User.current.uid
        let timeStamp = dateFormatter.string(from: Date())
        return Storage.storage().reference().child("images/posts/\(uid)/\(timeStamp).jpg")
    }
}
