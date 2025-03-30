//
//  ActorCell.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//

import UIKit

class ActorCell: UICollectionViewCell {
    
    static let identifier = "ActorCell"
    
    private let actorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .blue
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actorImageView)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        actorImageView.frame = CGRect(x: 5, y: 5, width: contentView.frame.width - 10, height: contentView.frame.height - 30)
        nameLabel.frame = CGRect(x: 5, y: contentView.frame.height - 25, width: contentView.frame.width - 10, height: 20)
    }
    
    func configure(with actor: Actor) {
        nameLabel.text = actor.name

        if let imageUrls = URL(string: actor.photo ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrls) {
                    DispatchQueue.main.async {
                        self.actorImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
