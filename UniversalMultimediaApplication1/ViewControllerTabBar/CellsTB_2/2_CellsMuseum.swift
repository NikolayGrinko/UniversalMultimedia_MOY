//
//  CellsMuseum.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 30.01.2025.
//

//import UIKit
//import Alamofire
//import SDWebImage
//
//class CellsMuseum: UICollectionViewCell {
//    
//    
//    static let identifier = "CellsMuseum"
//    
//    let imageViews: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .red
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .systemGray6
//        return imageView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(imageViews)
//        imageViews.layer.cornerRadius = 8
//        imageViews.clipsToBounds = true
//        imageViews.backgroundColor = .red
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupConstraints() {
//        
//        NSLayoutConstraint.activate([
//            
//            imageViews.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageViews.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageViews.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: -5)
//        ])
//    }
//    
//    func configure(with artObject: ArtObject) {
//        
//       // imageViews.sd_setImage(with: .init(string: artObject.webImage.url))
//        
//    }
//    
//}
