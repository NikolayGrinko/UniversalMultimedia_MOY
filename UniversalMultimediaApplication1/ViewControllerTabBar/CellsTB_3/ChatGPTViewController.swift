//
//  ChatViewController.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 27.02.2025.
//

import UIKit

final class ChatGPTViewController: UIViewController {
    
    private let service = OpenAIService()
    private let apiKey: String
    
    private lazy var inputField: UITextField = ChatGPT_VC.createTextField(placeholder: "Введите сообщение...", isSecure: false)
    private let responseTextView = UITextView()
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Отправить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        button.layer.cornerRadius = 15
        button.backgroundColor = #colorLiteral(red: 0.0994958058, green: 0.3159036636, blue: 0.9483405948, alpha: 1)
        button.frame = CGRect(x: view.frame.size.width / 2 - 40, y: 290, width: 100, height: 40)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        return button
    }()
    
    init(apiKey: String) {
        self.apiKey = apiKey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
       
        view.addSubview(inputField)
        view.addSubview(sendButton)
        view.addSubview(responseTextView)
        
        inputField.frame = CGRect(x: 20, y: 200, width: 350, height: 40)
        responseTextView.frame = CGRect(x: 20, y: 250, width: 350, height: 30)
     
        responseTextView.textColor = .white
        responseTextView.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        responseTextView.layer.cornerRadius = 10
        responseTextView.font = UIFont.systemFont(ofSize: 16)
        
    }
    
    @objc private func sendMessage() {
        guard let message = inputField.text, !message.isEmpty else { return }
        service.sendMessage(apiKey: apiKey, message: message) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response): self.responseTextView.text = response
                case .failure: self.responseTextView.text = "Ошибка запроса"
                }
            }
        }
    }
}
