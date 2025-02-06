//
//  MovieDetailViewController.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 06.02.2025.
//


import UIKit

class MovieDetailViewController: UIViewController {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let imageViews: UIImageView = {
        let imageViews = UIImageView()
        imageViews.contentMode = .scaleAspectFill
        imageViews.clipsToBounds = true
        imageViews.layer.cornerRadius = 8
        return imageViews
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        
        if let imageUrls = URL(string: movie.poster?.url ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrls) {
                    DispatchQueue.main.async {
                        self.imageViews.image = UIImage(data: data)
                    }
                }
            }
        }
       
        let labelsDescr = UILabel()
        labelsDescr.numberOfLines = 0
        labelsDescr.textColor = .white
        labelsDescr.text = movie.description
        labelsDescr.font = UIFont.systemFont(ofSize: 16)
        
        let labelRat = UILabel()
        labelRat.text = "\(movie.rating)"
        labelRat.textColor = .white
        labelRat.font = UIFont.boldSystemFont(ofSize: 18)
       
        let titleLabel = UILabel()
        titleLabel.text = movie.name
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        view.addSubview(imageViews)
        view.addSubview(labelsDescr)
        view.addSubview(labelRat)
        view.addSubview(titleLabel)
        
        imageViews.translatesAutoresizingMaskIntoConstraints = false
        labelsDescr.translatesAutoresizingMaskIntoConstraints = false
        labelRat.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            
            imageViews.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            imageViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            imageViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            imageViews.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: imageViews.bottomAnchor, constant: 20),
            titleLabel.heightAnchor.constraint(equalToConstant: 40),
            titleLabel.widthAnchor.constraint(equalToConstant: 200),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelsDescr.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            labelsDescr.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            labelsDescr.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            labelRat.topAnchor.constraint(equalTo: labelsDescr.bottomAnchor, constant: 20),
            labelRat.heightAnchor.constraint(equalToConstant: 40),
            labelRat.widthAnchor.constraint(equalToConstant: 300),
            labelRat.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
