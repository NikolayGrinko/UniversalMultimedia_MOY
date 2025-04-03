//
//  AddTaskPresenterProtocol.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import Foundation

protocol AddTaskPresenterProtocol {
    func saveTask(_ task: TaskEntity)
}

class AddTaskPresenter: AddTaskPresenterProtocol {
    weak var view: AddTaskViewProtocol?
    var interactor: AddTaskInteractorProtocol?

    func saveTask(_ task: TaskEntity) {
        print("📡 AddTaskPresenter: передаём задачу \(task.todo)") // ✅ Должно появиться в консоли
        interactor?.saveTask(task)
        view?.dismissView()
    }
}
