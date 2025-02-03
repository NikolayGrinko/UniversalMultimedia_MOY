//
//  UnsplashPhoto.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 03.02.2025.
//
import Foundation

struct UnsplashPhotoAll: Decodable {
    let id: String
    let description: String?
    let urls: PhotoURLs
}

struct PhotoURLs: Decodable {
    let regular: String
}
