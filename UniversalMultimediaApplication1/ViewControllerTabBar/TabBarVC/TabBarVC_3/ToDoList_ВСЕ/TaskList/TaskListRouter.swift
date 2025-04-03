//
//  TaskListRouter.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import UIKit

class TaskListRouter {
    static func createModule() -> UIViewController {
        let view = TaskListView()
        let presenter = TaskListPresenter()
        let interactor = TaskListInteractor()

        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter

        return view
    }
}
