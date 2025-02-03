//
//  Class_Object_TBC_1.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 29.01.2025.
//

import Foundation

class Class_Object_TBC_1: NSObject {
    
    let farm: Int
    let server: String
    let photoID: String
    let secret: String
    let url: String
    
    init(farm: Int, server: String, photoID: String, secret: String) {
        self.farm = farm
        self.server = server
        self.photoID = photoID
        self.secret = secret
        self.url = "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_m.jpg"
    }
}
