//
//  StorageService.swift
//  Makestagram
//
//  Created by Asher Rosenblatt on 6/27/17.
//  Copyright © 2017 AVRTech. All rights reserved.
//

import UIKit
import FirebaseStorage

class StorageService
{
    static func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void)
    {
        guard let imageData = UIImageJPEGRepresentation(image, 0.1) else { return completion(nil) }
        reference.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error
            {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            completion(metadata?.downloadURL())
        }
    }
}
