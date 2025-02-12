//
//  RusMuseum.swift
//  Museum_API
//
//  Created by Николай Гринько on 12.02.2025.
//

import UIKit

struct RusMuseums: Codable {
    let items: [Item]
}

struct Item: Codable {
    let edmIsShownBy: [String]?
    let edmPreview: [String]?
    let edmPlaceAltLabel: [EdmLabel]?
}

struct EdmLabel: Codable {
    let def: String
}
