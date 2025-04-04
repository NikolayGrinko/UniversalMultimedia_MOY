//
//  ViewController.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 01.04.2025.
//

import UIKit

class Wildberries: UIViewController {

    private let pressTheForwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2066813409, green: 0.7795598507, blue: 0.3491449356, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Нажми чтобы перейти", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    private var textView: UITextView = {
       let text = UITextView()
        text.font = .systemFont(ofSize: 24, weight: .bold)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.text = "Вы попали на контроллер, с которого перейдете на главный экран wildberries с ячейками в которых есть фото, title, descriptions. При нажатии открывается полное описание продукта. Есть корзина, в которой отображается добавленный товар и сумма, также количество товаров в корзине. Плюс реализовал здесь SkeletonView"
        text.textColor = .systemOrange
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
        override func viewDidLoad() {
            super.viewDidLoad()
            gradientView()
            setupButton()
            setupConstraints()
            setupNavigationBar()
        }
        
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
    
        private func setupButton() {
           
            view.addSubview(pressTheForwardButton)
            view.addSubview(textView)
            pressTheForwardButton.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
        
        private func setupNavigationBar() {
            // Configure navigation bar appearance
            if #available(iOS 13.0, *) {
                let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
                appearance.shadowColor = .clear
                
                appearance.titleTextAttributes = [
                    .foregroundColor: UIColor.white,
                    .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                ]
                
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
            }
            
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.isTranslucent = false
            title = "Wildberries"
        }
        
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -250),
            
            pressTheForwardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            pressTheForwardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            pressTheForwardButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pressTheForwardButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
        @objc private func tapButton() {
            let rootVC = Wildberries_1()
            navigationController?.pushViewController(rootVC, animated: true)
        }
    }
