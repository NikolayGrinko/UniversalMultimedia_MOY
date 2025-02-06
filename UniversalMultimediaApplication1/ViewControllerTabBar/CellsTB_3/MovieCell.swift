//
//  MovieCell.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 06.02.2025.
//


import UIKit

class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = CGRect(x: 0, y: 0, width: contentView.frame.width * 0.4, height: contentView.frame.height)
        titleLabel.frame = CGRect(x: movieImageView.frame.maxX + 8, y: 8, width: contentView.frame.width - movieImageView.frame.width - 16, height: 40)
        descriptionLabel.frame = CGRect(x: movieImageView.frame.maxX + 8, y: titleLabel.frame.maxY + 4, width: contentView.frame.width - movieImageView.frame.width - 16, height: 60)
    }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.name
        descriptionLabel.text = movie.description
        if let imageUrl = URL(string: movie.poster?.url ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
