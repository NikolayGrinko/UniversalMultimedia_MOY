//
//  Extension_UIIMageView.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }

        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
