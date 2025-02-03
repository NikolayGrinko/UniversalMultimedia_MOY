//
//  RandomVC.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 20.01.2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    lazy var buttonOne: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Это кнопка номер один", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.addShadow()
        button.frame = CGRect(x: 16, y: 130, width: 350, height: 100)
        button.addTarget(self, action: #selector(tapNextBarOneButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonTwo: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Это кнопка номер два", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 16, y: 280, width: 350, height: 100)
        button.addTarget(self, action: #selector(tapNextBarTwoButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonThree: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Это кнопка номер три", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 16, y: 430, width: 350, height: 100)
        button.addTarget(self, action: #selector(tapNextBarThreeButton), for: .touchUpInside)
        return button
    }()
    
    lazy var buttonFour: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Это кнопка номер четыре", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2824099586, green: 0.2401617251, blue: 0.5460324755, alpha: 1)
        button.frame = CGRect(x: 16, y: 580, width: 350, height: 100)
        button.addTarget(self, action: #selector(tapNextBarFourButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Все что нужно здесь 👇"
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
//        let navigationController = UINavigationController(rootViewController: vc)
//        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
//        present(navigationController, animated: true, completion: nil)
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
    
    @objc private func tapNextBarTwoButton() {
        let vc = TabBarControllerTwo()

        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true)
    }
    
    @objc private func tapNextBarThreeButton() {
        let vc = TabBarControllerThree()
        
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true)
    }
    
    @objc private func tapNextBarFourButton() {
        let vc = TabBarControllerFour()
        
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true)
    }
    
}
