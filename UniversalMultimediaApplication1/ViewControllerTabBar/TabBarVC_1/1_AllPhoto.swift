//
//  HomeVC_One.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 29.01.2025.
//

import UIKit
import Alamofire


class AllPhoto: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    private var photos: [UnsplashPhotoAll] = []
    
    
    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "ALL PHOTOS"
        photoLab.textColor = .systemBlue
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 135, y: 55, width: 150, height: 35)
        return photoLab
    }()
    
    
    lazy var buttonLeft: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.frame = CGRect(x: 10, y: 50, width: 40, height: 35)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchPhotos()
        
        view.addSubview(photoLabel)
        view.addSubview(buttonLeft)
        view.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        tableView.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        
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
    
    @objc private func didTapButton() {
        let vc = HomeViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CellsMemTB_1.self, forCellReuseIdentifier: "PhotoCell")
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableView.automaticDimension
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 85),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func fetchPhotos() {
        let urlString = "https://api.unsplash.com/photos?page=346&client_id=cNtxMzMLT8_GFa8TE8ACB5MWVJFOILOE57YRviGQxuI"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let response = try JSONDecoder().decode([UnsplashPhotoAll].self, from: data)
                DispatchQueue.main.async {
                    self.photos = response
                    self.tableView.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! CellsMemTB_1
        cell.configure(with: photos[indexPath.row])
        cell.backgroundColor = #colorLiteral(red: 0.5458797216, green: 0.1337981224, blue: 0.4389412999, alpha: 1)
        return cell
    }
    
}
