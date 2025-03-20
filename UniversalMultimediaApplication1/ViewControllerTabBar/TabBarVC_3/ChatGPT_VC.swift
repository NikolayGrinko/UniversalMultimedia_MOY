//
//  OneViewController.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 27.02.2025.
//

import UIKit

class ChatGPT_VC: UIViewController {
   
   private lazy var loginField: UITextField = ChatGPT_VC.createTextField(placeholder: "Login", isSecure: false)
   private lazy var passwordField: UITextField = ChatGPT_VC.createTextField(placeholder: "Password", isSecure: false)
   private lazy var apiKeyField: UITextField = ChatGPT_VC.createTextField(placeholder: "API Key", isSecure: false)
   private var titleLabel = UILabel()
   private var titleLabelText = UILabel()
   
     lazy var loginButton: UIButton = {
         let button = UIButton(type: .custom)
         button.setTitle("Войти", for: .normal)
         button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
         button.layer.cornerRadius = 15
         button.backgroundColor = #colorLiteral(red: 0.0994958058, green: 0.3159036636, blue: 0.9483405948, alpha: 1)
         button.frame = CGRect(x: view.frame.size.width / 2 - 40, y: 520, width: 80, height: 40)
         button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
         return button
     }()
    
   override func viewDidLoad() {
       super.viewDidLoad()
       view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
       
       view.addSubview(titleLabel)
       view.addSubview(titleLabelText)
       view.addSubview(loginField)
       view.addSubview(passwordField)
       view.addSubview(apiKeyField)
       view.addSubview(loginButton)
       
       setting()
   }
 
    private func setting() {
        titleLabel.text = "ChatGPT"
        titleLabel.frame = CGRect(x: view.frame.size.width / 2 - 40, y: 70, width: 80, height: 20)
        titleLabel.textColor = .systemOrange
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        titleLabelText.text = "Введите данные в поля ниже. Login, Password, APIKey - после регистрации возьмите перейдя по адресу: https://platform.openai.com/settings. В поле API_Keys найдите 'key', введите или создайте его."
        titleLabelText.numberOfLines = 0
        titleLabelText.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        titleLabelText.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabelText.textAlignment = .center
        titleLabelText.frame = CGRect(x: 35, y: 120, width: 330, height: 120)
        loginField.frame = CGRect(x: 20, y: 300, width: 350, height: 40)
        passwordField.frame = CGRect(x: 20, y: 380, width: 350, height: 40)
        apiKeyField.frame = CGRect(x: 20, y: 450, width: 350, height: 40)
    }
    
   static func createTextField(placeholder: String, isSecure: Bool) -> UITextField {
       let textField = UITextField()
       textField.placeholder = placeholder
       textField.borderStyle = .none
       textField.layer.borderWidth = 1
       textField.backgroundColor = .cyan
       textField.tintColor = .red
       textField.textColor = .black
       textField.layer.borderColor = UIColor.lightGray.cgColor
       textField.layer.cornerRadius = 10
       textField.isSecureTextEntry = isSecure
       textField.setLeftPaddingPoints(12)
       return textField
   }
   
   @objc private func loginTapped() {
       guard let login = loginField.text, !login.isEmpty,
             let password = passwordField.text, !password.isEmpty,
             let apiKey = apiKeyField.text, !apiKey.isEmpty else {
           return
       }
       
       KeychainService.save(apiKey: apiKey)
       let chatVC = ChatGPTViewController(apiKey: apiKey)
       navigationController?.pushViewController(chatVC, animated: true)
   }
}

private extension UITextField {
   
   func  setLeftPaddingPoints(_ amount: CGFloat) {
       let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
       self.leftView = paddingView
       self.leftViewMode = .always
   }
}
