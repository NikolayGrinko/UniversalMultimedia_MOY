//
//  TaskResponse.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import Foundation

struct TaskResponse: Codable {
    let todos: [TodoItem]
}

struct TodoItem: Codable {
    let id: Int
    let todo: String
    let completed: Bool
    let userId: Int  // ✅ Добавили userId
}
