//
//  MuseumVC_Two.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class MuseumVC_Two: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private var collectionView: UICollectionView!
    private var items: [Item] = []
    
    private var museumLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "Museum EUROPA"
        photoLab.textColor = .systemBlue
        photoLab.numberOfLines = 1
        photoLab.textAlignment = .center
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 90, y: 60, width: 220, height: 55)
        return photoLab
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        view.addSubview(museumLabel)
        setupCollectionView()
        fetchMuseumData()
        
        if let tabBar = self.tabBarController?.tabBar {
            // Убираем фон
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear // Прозрачный фон
            appearance.shadowColor = .clear    // Убираем нижнюю границу
            
            // Применяем стиль к TabBar
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.itemSize = CGSize(width: view.frame.width - 20, height: 180)
        
        collectionView = UICollectionView(frame: CGRect(x: 10, y: 115, width: view.frame.size.width, height: view.frame.size.height), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        collectionView.register(MuseumCell.self, forCellWithReuseIdentifier: "MuseumCell")
        view.addSubview(collectionView)
    }
    
    private func fetchMuseumData() {
        guard let url = URL(string: "https://api.europeana.eu/record/v2/search.json?wskey=api2demo&query=DATA_PROVIDER:%22Rijksmuseum%22") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let result = try JSONDecoder().decode(RusMuseums.self, from: data)
                DispatchQueue.main.async {
                    self.items = result.items
                    self.collectionView.reloadData()
                }
            } catch {
                print("Error decoding: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    // MARK: - CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MuseumCell", for: indexPath) as! MuseumCell
        cell.configure(with: items[indexPath.row])
        cell.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = MuseumDetailViewController(item: items[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

