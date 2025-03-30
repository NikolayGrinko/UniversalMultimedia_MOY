//
//  MovieDetailViewController.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 06.02.2025.
//


import UIKit


class MovieDetailViewController: UIViewController {
    
    var movie: Movie
    var actors: [Actor] = []
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let actorsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 150)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ActorCell.self, forCellWithReuseIdentifier: "ActorCell")
        return collectionView
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        setupViews()
        configureData()
    }
    
    private func setupViews() {
        view.addSubview(movieImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(yearLabel)
        view.addSubview(ratingLabel)
        view.addSubview(actorsCollectionView)
        
        actorsCollectionView.delegate = self
        actorsCollectionView.dataSource = self
        actorsCollectionView.backgroundColor = .systemGray
        // Добавляем констрейты
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        actorsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImageView.widthAnchor.constraint(equalToConstant: 200),
            movieImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            yearLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            yearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            ratingLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 10),
            ratingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            actorsCollectionView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10),
            actorsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            actorsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            actorsCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureData() {
       // movieImageView.loadImage(from: "\(movie.poster?.url)")
        titleLabel.text = movie.name
        descriptionLabel.text = movie.description
        yearLabel.text = "Год выпуска: \(String(describing: movie.year))"
        ratingLabel.text = "Рейтинг: \(String(describing: movie.rating))"
        
        if let imageUrls = URL(string: movie.poster?.url ?? "") {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrls) {
                    DispatchQueue.main.async {
                        self.movieImageView.image = UIImage(data: data)
                    }
                }
            }
        }
        
        actorsCollectionView.reloadData()
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie.actors?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActorCell", for: indexPath) as! ActorCell
        let actor = movie.actors![indexPath.item]
        cell.configure(with: actor)
        cell.backgroundColor = .blue
        actorsCollectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let actor = (movie.actors![indexPath.item])
        let actorVC = ActorDetailViewController(actor: actor)
        navigationController?.pushViewController(actorVC, animated: true)
    }
}
