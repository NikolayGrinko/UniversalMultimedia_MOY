//
//  Meme.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 02.02.2025.
//


import UIKit

// MARK: - Meme Model
struct MemeModel: Decodable {
    let id: String
    let name: String
    let url: String
}

struct MemeResponseData: Decodable {
    let memes: [Meme]
}

struct MemeResponse: Decodable {
    let data: MemeResponseData
}
