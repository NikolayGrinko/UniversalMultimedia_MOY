//
//  CellsMemTB_1.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 22.01.2025.
//

import UIKit


    class CellsMemTB_1: UITableViewCell {
        let photoImageView = UIImageView()
        let titleLabel = UILabel()
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupUI()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupUI() {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.clipsToBounds = true
            titleLabel.textAlignment = .center
            titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
            titleLabel.numberOfLines = 0
            
            contentView.addSubview(photoImageView)
            contentView.addSubview(titleLabel)
            photoImageView.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                photoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                photoImageView.widthAnchor.constraint(equalToConstant: 200),
                photoImageView.heightAnchor.constraint(equalToConstant: 200),
                
                titleLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }
        
        func configure(with photo: UnsplashPhotoAll) {
            titleLabel.text = photo.description ?? "No Description"
            loadImage(from: photo.urls.regular)
        }
        
        private func loadImage(from url: String) {
            guard let imageUrl = URL(string: url) else { return }
            URLSession.shared.dataTask(with: imageUrl) { data, _, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    self.photoImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
