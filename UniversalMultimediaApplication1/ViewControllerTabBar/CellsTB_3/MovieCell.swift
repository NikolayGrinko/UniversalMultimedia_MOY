//
//  MovieCell.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//

import UIKit

// MARK: - MovieCell for CollectionView
class MovieCell: UICollectionViewCell {
    
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageViewPoster = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nameLabel.textColor = .white
        nameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        descriptionLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        descriptionLabel.textColor = .white
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageViewPoster)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        nameLabel.font = .boldSystemFont(ofSize: 16)
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 4
        
        imageViewPoster.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            imageViewPoster.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageViewPoster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            imageViewPoster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            imageViewPoster.widthAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: imageViewPoster.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
           
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: imageViewPoster.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
           
            ])
    }

    func configure(with movie: Movie) {
        nameLabel.text = movie.name
        descriptionLabel.text = movie.description
        if let imageUrls = URL(string: movie.poster?.url ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrls) {
                    DispatchQueue.main.async {
                        self.imageViewPoster.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
