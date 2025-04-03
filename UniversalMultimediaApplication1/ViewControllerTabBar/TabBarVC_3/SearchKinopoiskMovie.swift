//
//  SearchKinopoiskMovie.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class SearchKinopoiskMovie: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    private var movies: [Movie] = []
    
    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "Поиск ФИЛЬМОВ"
        photoLab.textColor = .systemBlue
        photoLab.numberOfLines = 1
        photoLab.textAlignment = .center
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 100, y: 50, width: 200, height: 55)
        return photoLab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        view.addSubview(searchBar)
        view.addSubview(photoLabel)
        setupSearchBar()
        setupCollectionView()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = "Search movies..."
        searchBar.sizeToFit()
        searchBar.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        searchBar.barTintColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        searchBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationItem.titleView = searchBar
        searchBar.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 50)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 100)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 160, width: view.frame.size.width, height: view.frame.size.height - 80), collectionViewLayout: layout)
        collectionView.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        view.addSubview(collectionView)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchMovies(query: query)
    }
    
    private func fetchMovies(query: String) {
        let urlString = "https://api.kinopoisk.dev/v1.4/movie/search?page=1&limit=10&query=\(query)"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("NVCS5FH-72K4GM4-MXNKNSA-VYQT0YG", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                print(data)
                print(decodedResponse)
                DispatchQueue.main.async {
                    self.movies = decodedResponse.movies
                    self.collectionView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        cell.configure(with: movies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MovieDetailViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

