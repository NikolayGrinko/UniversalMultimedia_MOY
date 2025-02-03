//
//  GifModel.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 27.01.2025.
//

import Foundation

struct GIFModels: Codable {
    let data: DataClas
}

// MARK: - DataClass
struct DataClas: Codable {
   
    let url: String
   

    enum CodingKeys: String, CodingKey {
        case url
    }
}
