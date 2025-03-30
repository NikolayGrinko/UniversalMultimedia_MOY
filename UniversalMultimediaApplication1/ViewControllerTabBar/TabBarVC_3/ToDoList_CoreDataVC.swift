//
//  SettingsVC_Two.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class ToDoList_CoreDataVC: UIViewController {
    
    let textField: UITextView = {
        let text = UITextView()
        text.text = "Этот ToDoList сделан с помощью паттерна VIPER. Происходит загрузка 30 заметок, некоторые из них true and false. Естественно отмечены, как заполненные или нет. Можно добавить задачу, введя заранее данные и сохранить. Новую задачу можно отметить выполненной или нет. При повторной загрузке приложения, происходит загрузка с CoreData, а затем с API"
        text.textColor = .systemOrange
        text.font = .systemFont(ofSize: 20)
        text.textAlignment = .center
        text.backgroundColor = .clear
        text.frame = CGRect(x: 20, y: 100, width: 350, height: 300)
        return text
    }()
    
    lazy var buttonTapForward: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(forvardButtonTap), for: .touchUpInside)
        button.frame = CGRect(x: view.frame.size.width / 2 - 50, y: 430, width: 100, height: 40)
        button.setTitle("Вперед", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    
    
    @objc private func forvardButtonTap() {
        print("TapForvard")
       // TaskListRouter.createModule()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        view.addSubview(buttonTapForward)
        
        
        gradientView()
    }
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
}
