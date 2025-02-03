//
//  HomeViewController.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class HomeVC_Three: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView()
    }
    private func gradientView() {
        view.applyGradient(colors: [.customBlue, .customGreen],
                                   startPoint: CGPoint(x: 0.0, y: 0.0),
                                   endPoint: CGPoint(x: 1.0, y: 1.0))
    }
}
