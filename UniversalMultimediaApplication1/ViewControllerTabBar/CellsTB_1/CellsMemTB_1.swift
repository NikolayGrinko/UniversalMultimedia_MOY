//
//  CellsMemTB_1.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 22.01.2025.
//

import UIKit
import Alamofire

class CellsMemTB_1: UICollectionViewCell {
    
    var request: Alamofire.Request?
    
    static let identifier = "CellsMemTB_1"
    
    let imageViews: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageViews)
        imageViews.layer.cornerRadius = 8
        imageViews.clipsToBounds = true
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            imageViews.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageViews.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -5)
        ])
    }
}
