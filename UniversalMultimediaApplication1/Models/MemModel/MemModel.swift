//
//  MemModel.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 21.01.2025.
//


import Foundation

// MARK: - MemModel
struct MemModel: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let boxCount: Int
    let captions: Int

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case width
        case height
        case boxCount = "box_count"
        case captions
    }
}
