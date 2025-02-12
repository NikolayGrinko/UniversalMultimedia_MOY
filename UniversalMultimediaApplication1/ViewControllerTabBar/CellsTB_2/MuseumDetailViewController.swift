//
//  MuseumDetailViewController.swift
//  Museum_API
//
//  Created by Николай Гринько on 12.02.2025.
//
import UIKit


// MARK: - Detail View Controller
class MuseumDetailViewController: UIViewController {
    private let item: Item
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        title = "Rijksmuseum"
        setupViews()
    }
    
    private func setupViews() {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        if let imageUrl = item.edmIsShownBy?.first, let url = URL(string: imageUrl) {
            loadImage(from: url, into: imageView)
        }
        
        let nameLabel = UILabel()
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.textAlignment = .center
        nameLabel.text = item.edmPlaceAltLabel?.first?.def
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data, let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                imageView.image = image
            }
        }.resume()
    }
}
