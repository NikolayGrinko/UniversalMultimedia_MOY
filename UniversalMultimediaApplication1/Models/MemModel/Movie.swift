//
//  Movie.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//

import Foundation


// MARK: - MovieResponse
struct MovieResponse: Codable {
    let total: Int
    let movies: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case total
        case movies = "docs"
    }
}

// MARK: - Movie
struct Movie: Codable {
    let id: Int
    let name: String?
    let description: String?
    let year: Int?
    let rating: Rating?
    let poster: Poster?
    let actors: [Actor]?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description
        case year
        case rating
        case poster
        case actors = "persons"
    }
}

struct Rating: Codable {
    let kp: Double?
}

// MARK: - Poster
struct Poster: Codable {
    let url: String?
}

// MARK: - Actor
struct Actor: Codable {
    let id: Int
    let name: String?
    let photo: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photo = "photo"
    }
}
//
//struct MovieResponse: Codable {
//    let docs: [Movie]  // API возвращает фильмы в поле "docs"
//}
//
//struct Movie: Codable {
//    let name: String?
//    let description: String?
//    let year: Int?
//    let rating: Rating
//    let poster: Poster?
//
//    struct Rating: Codable {
//        let kp: Double?  // Рейтинг от Кинопоиска
//    }
//
//    struct Poster: Codable {
//        let url: String?
//    }
//}
