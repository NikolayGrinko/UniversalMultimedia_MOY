//
//  LoginRegistrationVC.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 20.01.2025.
//

// ClientID - 968246070699-njdqhlmlh37kgouqjn392vdbd823pjhd.apps.googleusercontent.com

import UIKit
import GoogleSignIn

class LoginRegistrationVC: UIViewController, UITextFieldDelegate {
    
    private lazy var signInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .wide
        button.colorScheme = .dark
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private let titleLabels: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Переопределяемый метод UITextField
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
        print("🟢 ViewDidLoad started")
        
        view.addSubview(signInButton)
        setupGoogleSignIn()
        setupUI()
        setupToggleButton()
        setupConfirmToggleButton()
       
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
       
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped(_:)))
        signInButton.addGestureRecognizer(tapGesture)
        
        print("🟢 Added tap gesture recognizer to button")
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                print("🔴 Error checking previous sign-in: \(error.localizedDescription)")
            }
            if let user = user {
                print("🟢 Found previous sign-in: \(user.profile?.email ?? "no email")")
            } else {
                print("🟢 No previous sign-in found")
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🟢 ViewWillAppear")
        // Check existing sign in when view appears
        checkExistingSignIn()
    }
    
    private func checkExistingSignIn() {
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [weak self] user, error in
                if let error = error {
                    print("Error restoring sign in: \(error.localizedDescription)")
                } else if let user = user {
                    self?.proceedToProfile(with: user)
                }
            }
        }
    }
   
    private func setupGoogleSignIn() {
        print("🟢 Setting up Google Sign In...")
        
        let clientID = "968246070699-njdqhlmlh37kgouqjn392vdbd823pjhd.apps.googleusercontent.com"
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
        print("🟢 Google Sign In configuration set with clientID: \(clientID)")
    }
    
    @objc private func buttonTapped(_ sender: UITapGestureRecognizer) {
        print("🟢 Button tapped via gesture recognizer")
        signInTapped()
    }
    
    @objc private func signInTapped() {
        print("🟢 Sign In Button Tapped!")
        
        print("🟢 Starting Google Sign In process...")
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] signInResult, error in
            guard let self = self else {
                print("🔴 Self is nil in completion handler")
                return
            }
            
            if let error = error {
                print("🔴 Sign In Error: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: error.localizedDescription)
                }
                return
            }
            
            print("🟢 Sign in attempt completed")
            
            guard let signInResult = signInResult else {
                print("🔴 No sign in result")
                return
            }
            
            guard let profile = signInResult.user.profile else {
                print("🔴 No user profile")
                return
            }
            
            print("🟢 Successfully signed in!")
            print("User: \(profile.name ?? "No name")")
            print("Email: \(profile.email)")
            
            DispatchQueue.main.async {
                let homeVC = HomeViewController()
                let navigationController = UINavigationController(rootViewController: homeVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true) {
                    print("🟢 Presented HomeViewController")
                }
            }
        }
    }
    
    private func proceedToProfile(with user: GIDGoogleUser) {
       
        let profileVC = HomeViewController()
        navigationController?.pushViewController(profileVC, animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
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
            //stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor), stackViewTopConstraints!,
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 300),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600),
            signInButton.widthAnchor.constraint(equalToConstant: 280),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        forgotPasswordButton.isHidden = !isLoginMode
        
        signInButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        signInButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc private func buttonTouchDown() {
        signInButton.alpha = 0.7
    }
    
    @objc private func buttonTouchUp() {
        signInButton.alpha = 1.0
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
