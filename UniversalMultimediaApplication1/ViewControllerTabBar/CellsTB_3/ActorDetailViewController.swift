//
//  ActorDetailViewController.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//
import UIKit

class ActorDetailViewController: UIViewController {
    let actor: Actor
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let biographyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    init(actor: Actor) {
        self.actor = actor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        view.addSubview(nameLabel)
        view.addSubview(biographyLabel)
        configure()
    }
    
    private func configure() {
        nameLabel.text = actor.name
        biographyLabel.text = actor.name
//        if let imageUrl = URL(string: actor.photo!) {
//            imageView.loadImage(from: "\(imageUrl)")
//        }
        if let imageUrls = URL(string: actor.photo ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrls) {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let padding: CGFloat = 20
        imageView.frame = CGRect(x: padding, y: view.safeAreaInsets.top + padding, width: view.frame.width - 2 * padding, height: 300)
        nameLabel.frame = CGRect(x: padding, y: imageView.frame.maxY + 10, width: view.frame.width - 2 * padding, height: 30)
        biographyLabel.frame = CGRect(x: padding, y: nameLabel.frame.maxY + 10, width: view.frame.width - 2 * padding, height: view.frame.height - nameLabel.frame.maxY - 20)
    }
}
