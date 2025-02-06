//
//  Movie.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 06.02.2025.
//

import Foundation


struct MovieResponse: Codable {
    let docs: [Movie]  // API возвращает фильмы в поле "docs"
}

struct Movie: Codable {
    let name: String?
    let description: String?
    let year: Int?
    let rating: Rating
    let poster: Poster?

    struct Rating: Codable {
        let kp: Double?  // Рейтинг от Кинопоиска
    }

    struct Poster: Codable {
        let url: String?
    }
}
