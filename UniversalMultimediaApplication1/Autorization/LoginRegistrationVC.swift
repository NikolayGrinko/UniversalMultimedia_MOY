//
//  LoginRegistrationVC.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 20.01.2025.
//

import UIKit

class LoginRegistrationVC: UIViewController, UITextFieldDelegate {
    
    private let titleLabels: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func createTextField(placeholder: String, isSecure: Bool) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = isSecure
        textField.setLeftPaddingPoints(12)
        textField.backgroundColor = .systemGray4
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private let toggleButtonEye: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(systemName: "eye.circle") // Иконка глаза (открытое состояние)
            button.setImage(image, for: .normal)
        button.tintColor = .black
            return button
        }()
    
    private let toggleConfirmButtonEye: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(systemName: "eye.circle") // Иконка глаза (открытое состояние)
            button.setImage(image, for: .normal)
            button.tintColor = .black
            return button
        }()
    
    private func setupToggleButton() {
           // Установка кнопки в правую часть текстового поля
        toggleButtonEye.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        toggleButtonEye.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
           
           // Устанавливаем кнопку как `rightView` для текстового поля
           passwordTextField.rightView = toggleButtonEye
           passwordTextField.rightViewMode = .always
       }
    
    private func setupConfirmToggleButton() {
           // Установка кнопки в правую часть текстового поля
        toggleConfirmButtonEye.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        toggleConfirmButtonEye.addTarget(self, action: #selector(toggleConfirmPasswordVisibility), for: .touchUpInside)
           
           // Устанавливаем кнопку как `rightView` для текстового поля
        confirmPasswordTextField.rightView = toggleConfirmButtonEye
        confirmPasswordTextField.rightViewMode = .always
       }
       
       @objc private func togglePasswordVisibility() {
           passwordTextField.isSecureTextEntry.toggle()
           
           // Меняем иконку в зависимости от состояния
           let imageName = passwordTextField.isSecureTextEntry ? "eye.circle" : "eye.slash.circle"
           toggleButtonEye.setImage(UIImage(systemName: imageName), for: .normal)
       }
    
    @objc private func toggleConfirmPasswordVisibility() {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        
        // Меняем иконку в зависимости от состояния
        let imageName = confirmPasswordTextField.isSecureTextEntry ? "eye.circle" : "eye.slash.circle"
        toggleConfirmButtonEye.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    private lazy var emailTextField: UITextField = createTextField(placeholder: "Email", isSecure: false)
    private lazy var passwordTextField: UITextField = createTextField(placeholder: "Password", isSecure: true)
    private lazy var confirmPasswordTextField: UITextField = createTextField(placeholder: "Confirm Password", isSecure: true)
    
    private let registerSwitchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not have account register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Enter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextTapVC), for: .touchUpInside)
        return button
    }()
    
    @objc private func nextTapVC() {
        let vc = HomeViewController()
        
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
        
    }
    
    private let termsCheckBox: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Terms & Conditions", for: .normal)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Forgot Password?", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var isLoginMode = true {
        didSet {
            toggleAuthMode()
        }
    }
    
    private var stackViewTopConstraints: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToggleButton()
        setupConfirmToggleButton()
       
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
        
        setupUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        stackViewTopConstraints?.constant = -keyboardFrame.height / 2
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        stackViewTopConstraints?.constant = 0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func textFieldShouldreturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabels,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField,
            termsCheckBox,
            actionButton,
            registerSwitchButton])
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        registerSwitchButton.addTarget(self, action: #selector(switchAuthMode), for: .touchUpInside)
        termsCheckBox.addTarget(self, action: #selector(showTermsAlert), for: .touchUpInside)
        
        stackViewTopConstraints = stackView.topAnchor.constraint(equalTo: view.centerYAnchor)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor), stackViewTopConstraints!,
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        forgotPasswordButton.isHidden = !isLoginMode
    }
    
    @objc private func switchAuthMode() {
        UIView.transition(with: view, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.isLoginMode.toggle()
        })
    }
    
    private func toggleAuthMode() {
        if isLoginMode {
            titleLabels.text = "Welcome"
            actionButton.setTitle("Login", for: .normal)
            registerSwitchButton.setTitle("Not have account Register", for: .normal)
            confirmPasswordTextField.isHidden = true
            termsCheckBox.isHidden = true
            forgotPasswordButton.isHidden = false
        } else {
            titleLabels.text = "Create account"
            actionButton.setTitle("Register", for: .normal)
            registerSwitchButton.setTitle("Already have account Login", for: .normal)
            confirmPasswordTextField.isHidden = false
            termsCheckBox.isHidden = false
            forgotPasswordButton.isHidden = true
        }
    }
    
    @objc private func showTermsAlert() {
        let alert = UIAlertController(title: "", message: "Confirm agreement", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

private extension UITextField {
    
    func  setLeftPaddingPoints(_ amount: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}

