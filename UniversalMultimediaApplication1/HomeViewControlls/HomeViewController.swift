//
//  RandomVC.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 20.01.2025.
//

import UIKit
import GoogleSignIn

class HomeViewController: UIViewController {
    
    lazy var buttonOne: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("All Photo / Search Photo / Шедеврум", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.addShadow()
        button.frame = CGRect(x: 15, y: 150, width: 380, height: 80)
        button.addTarget(self, action: #selector(tapNextBarOneButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonTwo: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Carusel / Museum / Gif", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 15, y: 260, width: 380, height: 80)
        button.addTarget(self, action: #selector(tapNextBarTwoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonThree: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("ChatGPT / Search Movie / ToDoList", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 15, y: 370, width: 380, height: 80)
        button.addTarget(self, action: #selector(tapNextBarThreeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonFour: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Wildberries/-----/------", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 15, y: 480, width: 380, height: 80)
        button.addTarget(self, action: #selector(tapNextBarFourButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var signOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SignOut", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Все что нужно здесь 👇"
        setupUI()
        settingUpButtons()
        
        buttonOne.addShadow()
        buttonTwo.addShadow()
        buttonFour.addShadow()
        buttonThree.addShadow()
        
        view.addSubview(buttonOne)
        view.addSubview(buttonTwo)
        view.addSubview(buttonThree)
        view.addSubview(buttonFour)
        gradientView()
    }
    
    private func setupUI() {
        view.addSubview(signOutButton)
        
        NSLayoutConstraint.activate([
            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signOutButton.widthAnchor.constraint(equalToConstant: 80),
            signOutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func settingUpButtons() {
        // Настраиваем цвет кнопки Title
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
                navigationController?.navigationBar.titleTextAttributes = textAttributes

                // Настраиваем цвет кнопки назад
        navigationController?.navigationBar.tintColor = .systemOrange
        // Выставляем кнопку назад
        navigationItem.titleView?.tintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(didTapButton))
        
    }
    // цвет Gradient - view
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
    @objc private func didTapButton() {
        let vc = LoginRegistrationVC()
       
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true)
    }
    
    
    @objc private func tapNextBarOneButton() {
        let vc = TabBarControllerOne()
        
        // Оборачиваем его в UINavigationController
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
    
    @objc private func tapNextBarTwoButton() {
        let vc = TabBarControllerTwo()

        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func tapNextBarThreeButton() {
        let vc = TabBarControllerThree()
        
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func tapNextBarFourButton() {
        let vc = TabBarControllerFour()
        
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc private func signOutTapped() {
        // Показываем alert с подтверждением
        let alert = UIAlertController(title: "Выход",
                                    message: "Вы уверены, что хотите выйти?",
                                    preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Выйти", style: .destructive) { [weak self] _ in
            self?.signOut()
        })
        
        present(alert, animated: true)
    }
    
    private func signOut() {
        // Выходим из Google аккаунта
        GIDSignIn.sharedInstance.signOut()
        
        // Возвращаемся на экран входа
        dismiss(animated: true) {
            print("🟢 Successfully signed out")
        }
    }
}
