//
//  AddTaskInteractorProtocol.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import Foundation

protocol AddTaskInteractorProtocol {
    func saveTask(_ task: TaskEntity)
}

class AddTaskInteractor: AddTaskInteractorProtocol {
    var presenter: AddTaskPresenterProtocol?

    func saveTask(_ task: TaskEntity) {
        
    print("📡 AddTaskInteractor: сохраняем задачу \(task.todo)") // ✅ Должно появиться в консоли
        CoreDataService.shared.saveTask(task)
    }
}
