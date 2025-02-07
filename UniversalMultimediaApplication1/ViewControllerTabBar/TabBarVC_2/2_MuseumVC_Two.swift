//
//  MuseumVC_Two.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import UIKit

class MuseumVC_Two: UIViewController {

    var artObject = [ArtObject]()
    
    private var photoLabel: UILabel = {
        let photoLab = UILabel()
        photoLab.text = "Museum Applications"
        photoLab.textColor = .systemBlue
        photoLab.textAlignment = .center
        photoLab.font = .systemFont(ofSize: 20, weight: .semibold, width: .standard)
        photoLab.frame = CGRect(x: 90, y: 50, width: 230, height: 55)
        return photoLab
    }()
    
    // Создаем таблицу и кнопку
//    private let tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
//        tableView.register(CellsMuseum.self, forCellReuseIdentifier: CellsMuseum.identifier)
//        return tableView
//    }()

    private let floatingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Нажми меня", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(photoLabel)
       // view.addSubview(tableView)
        view.addSubview(floatingButton)
        view.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
        // Устанавливаем делегаты и источник данных для таблицы
//        tableView.delegate = self
//        tableView.dataSource = self
        
        if let tabBar = self.tabBarController?.tabBar {
            // Убираем фон
            let appearance = UITabBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear // Прозрачный фон
            appearance.shadowColor = .clear    // Убираем нижнюю границу
            
            // Применяем стиль к TabBar
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = appearance
            
            // Настраиваем действие кнопки
            floatingButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            // Используем Auto Layout
            setupConstraints()
//            ApiReq_1TB.shared.downloadMuseum()
        }
    }
    
    private func setupConstraints() {
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        floatingButton.translatesAutoresizingMaskIntoConstraints = false
//
//        // Констрейнты для таблицы
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
//        ])

        // Констрейнты для кнопки
        NSLayoutConstraint.activate([
            floatingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            floatingButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            floatingButton.widthAnchor.constraint(equalToConstant: 150),
            floatingButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Действие кнопки
    @objc private func buttonTapped() {
        print("Кнопка нажата!")
    }

    // MARK: - UITableViewDataSource и UITableViewDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artObject.count // Количество строк
    }

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CellsMuseum.identifier, for: indexPath)
//        cell.backgroundColor = #colorLiteral(red: 0.5419899225, green: 0.1355841756, blue: 0.4403297007, alpha: 1)
//        
//       
//        //cell.textLabel?.text = "Элемент \(indexPath.row + 1)"
//        return cell
//    }
}



//
//
//switch indexPath.section {
//    
//case Sections.TrendingMuseum.rawValue:
//    
//    ApiReq_1TB.shared.downloadMuseum { result in
//        switch result {
//        case .success(let titles):
//            cell.configure(with: titles)
//        case .failure(let error):
//            print(error.localizedDescription)
//        }
//    }
//    
//
//default:
//    return UITableViewCell()
//}
//
//return cell
