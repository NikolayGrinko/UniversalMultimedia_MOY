//
//  MemeCell.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 02.02.2025.
//


import UIKit

// MARK: - Meme Cell
class MemeCell: UITableViewCell {
    let memeImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        memeImageView.contentMode = .scaleAspectFit
        memeImageView.clipsToBounds = true
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        contentView.addSubview(memeImageView)
        contentView.addSubview(titleLabel)
        memeImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            memeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            memeImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            memeImageView.widthAnchor.constraint(equalToConstant: 200),
            memeImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: memeImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with meme: Meme) {
        titleLabel.text = meme.name
        loadImage(from: meme.url)
    }
    
    private func loadImage(from url: String) {
        guard let imageUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: imageUrl) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.memeImageView.image = UIImage(data: data)
            }
        }.resume()
    }
}
