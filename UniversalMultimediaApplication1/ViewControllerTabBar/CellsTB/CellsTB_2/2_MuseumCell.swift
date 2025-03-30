//
//  MuseumCell.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 30.01.2025.
//

import UIKit

class MuseumCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.alignment = .center
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with item: Item) {
        nameLabel.text = item.edmPlaceAltLabel?.first?.def
        if let imageUrl = item.edmIsShownBy?.first, let url = URL(string: imageUrl) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
    }
}
