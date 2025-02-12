//
//  SettingsVC_One.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit
import WebKit

class Chedevrum: UIViewController {

    private let webView: WKWebView = {
        let webView = WKWebView()
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        webView.frame = CGRect(x: 0, y: 60, width: view.frame.size.width, height: view.frame.size.height)
        view.addSubview(webView)
        guard let url = URL(string: "https://shedevrum.ai/") else { return }
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
       // gradientView()
    }
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
}
