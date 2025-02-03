//
//  APIResponse.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 23.01.2025.
//


struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Result]
}
struct Result: Codable {
    let id: String
    let urls: URLS
    
}
struct URLS: Codable {
    let regular: String
}