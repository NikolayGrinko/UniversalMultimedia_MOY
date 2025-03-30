//
//  TaskDetailViewController.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import UIKit

class TaskDetailViewController: UIViewController {
    var task: TaskEntity? // ✅ Передаём задачу
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23)
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21)
        label.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        displayTaskDetails()
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.6369494796, green: 0.09633842856, blue: 0.4035278857, alpha: 1)
        title = "Детали задачи"
        
        let stackView = UIStackView(arrangedSubviews: [userLabel, dateLabel, titleLabel])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140),
        ])
    }
    
    private func displayTaskDetails() {
        guard let task = task else { return }
        
        userLabel.text = "👤 User \(task.userId)"
        titleLabel.text = "📌 \(task.todo)"
        dateLabel.text = "📅 \(formatDate(task.createdAt))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}
