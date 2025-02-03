//
//  HomeVC_One.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 29.01.2025.
//

import UIKit
import Alamofire


class HomeVC_One: UIViewController, UICollectionViewDataSource {
    
    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "ALL PHOTOS"
        photoLab.textColor = .systemBlue
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 135, y: 55, width: 150, height: 35)
        return photoLab
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        cv.register(CellsMemTB_1.self, forCellWithReuseIdentifier: CellsMemTB_1.identifier)
        return cv
    }()
    
    let key = "c5c4dd9d7c706bf5ae3e98cf7691ec75"
    let perPage = "365"
    let text = "Автомобили"
    
    var photos = NSMutableOrderedSet()
    
    let countItem: CGFloat = 2
    let sectionInsert = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    lazy var buttonLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.frame = CGRect(x: 10, y: 50, width: 40, height: 35)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(photoLabel)
        view.addSubview(buttonLeft)
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        
        if let tabBar = self.tabBarController?.tabBar {
            // Убираем фон
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear // Прозрачный фон
            appearance.shadowColor = .clear    // Убираем нижнюю границу
            
            // Применяем стиль к TabBar
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            
            view.addSubview(collectionView)
            collectionView.dataSource = self
            collectionView.delegate = self
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            
            let param = ["api_key": key,
                         "format": "json",
                         "method": "flickr.photos.search",
                         "per_page": perPage,
                         "text": text,
                         "nojsoncallback": "1"]
            
            AF.request("https://api.flickr.com/services/rest/", parameters: param).responseJSON { (responseJSON) in
                
                // print(responseJSON.description)
                
                switch responseJSON.result {
                case .success(let value):
                    //                guard let photos = FlickrPhoto.getArray(from: value) else { return }
                    //                self.flickrPhotoArray = photos
                    
                    guard
                        let jsonContainer = value as? [String: Any],
                        let jsonPhotos = jsonContainer["photos"] as? [String: Any],
                        let jsonArray = jsonPhotos["photo"] as? [[String: Any]]
                    else {
                        return
                    }
                    let flickrPhotosObj = jsonArray.map {
                        Class_Object_TBC_1(farm: $0["farm"] as! Int,
                                           server: $0["server"] as! String,
                                           photoID: $0["id"] as! String,
                                           secret: $0["secret"] as! String)
                    }
                    
                    self.photos.addObjects(from: flickrPhotosObj)
                    print(self.photos)
                    
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    
    @objc private func didTapButton() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellsMemTB_1.identifier, for: indexPath) as! CellsMemTB_1
        let imageURL = (photos.object(at: indexPath.row) as! Class_Object_TBC_1).url
        
        cell.backgroundColor = .systemBlue
        
        cell.request?.cancel()
        cell.request = AF.download(imageURL).responseData(completionHandler: { (response) in
            if let data = response.value {
                let image = UIImage(data: data)
                cell.imageViews.image = image
            }
        })
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 10
        let totalSpacing = (2 - 1) * padding + 20 // Отступы между ячейками и от краев
        let width = (collectionView.frame.width - totalSpacing) / 2
        return CGSize(width: width, height: 100)
    }
}

// size sections
extension HomeVC_One: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsert.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsert
    }
    
}
