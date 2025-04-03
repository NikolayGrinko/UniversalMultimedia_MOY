//
//  TaskEntity.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.reated by Николай Гринько on 25.03.2025.
//

import Foundation

struct TaskEntity: Codable {
    let id: Int64
    var todo: String
    var completed: Bool
    let createdAt: Date
    let userId: Int  
}
