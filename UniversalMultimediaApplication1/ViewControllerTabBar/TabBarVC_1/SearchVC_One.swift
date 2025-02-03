//
//  SearchVC_One.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class SearchVC_One: UIViewController, UICollectionViewDataSource, UISearchBarDelegate  {

    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "SEARCH PHOTOS"
        photoLab.textColor = .systemBlue
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 125, y: 50, width: 170, height: 35)
        return photoLab
    }()
    
    lazy var buttonLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.frame = CGRect(x: 10, y: 50, width: 40, height: 35)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    return button
    }()

var results: [Result] = []

let searchbar = UISearchBar()

private var collectionView: UICollectionView?

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
    view.addSubview(buttonLeft)
    view.addSubview(photoLabel)
    searchbar.delegate = self
    searchbar.layer.cornerRadius = 10
    searchbar.searchBarStyle = .minimal
    //searchbar.tintColor = #colorLiteral(red: 0.2591216081, green: 0.6814015893, blue: 0.985946014, alpha: 1)
    searchbar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    searchbar.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    searchbar.placeholder = "Введите текст поиска..."
    
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = 0
    // разделение на столбци
    layout.minimumInteritemSpacing = 0
    layout.itemSize = CGSize(width: view.frame.size.width/2, height: view.frame.size.width/2)
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    collectionView.dataSource = self
    view.addSubview(collectionView)
    view.addSubview(searchbar)
    
    collectionView.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
    self.collectionView = collectionView
    
}

    @objc private func didTapButton() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }

override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    searchbar.frame = CGRect(
        x: 00,
        y: view.safeAreaInsets.top + 30,
        width: view.frame.size.width,
        height: 50)
    collectionView?.frame = CGRect(
        x: 0,
        y: 130,
        width: view.frame.size.width,
        height: view.frame.size.height)
    
}
func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    // клавиатура скрывается
    searchBar.resignFirstResponder()
    if let text = searchbar.text {
        results = []
        collectionView?.reloadData()
        fetchPhotos(query: text)
        
    }
}

func fetchPhotos(query: String) {
    let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=cNtxMzMLT8_GFa8TE8ACB5MWVJFOILOE57YRviGQxuI"
    guard let url = URL(string: urlString) else {
        return
    }
    
    let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
        guard let data = data, error == nil else {
            return
        }
        do {
            let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self?.results = jsonResult.results
                self?.collectionView?.reloadData()
            }
        }
        catch {
            print(error)
        }
    }
    task.resume()
}

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
}
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let imageURLString = results[indexPath.row].urls.regular
   guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: ImageCollectionViewCell.identifier,
        for: indexPath
   ) as? ImageCollectionViewCell else {
       return UICollectionViewCell()
   }
    cell.configure(with: imageURLString)
    return cell
}
}

