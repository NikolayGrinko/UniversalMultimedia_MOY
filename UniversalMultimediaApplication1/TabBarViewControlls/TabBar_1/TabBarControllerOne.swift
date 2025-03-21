//
//  TabBarControllerOne.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//
import UIKit

class TabBarControllerOne: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .done, target: self, action: #selector(didTapButton))
    }
    
    @objc private func didTapButton() {
        let vc = HomeViewController()
       
        // Оборачиваем его в UINavigationController
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen // Для полноэкранного отображения
        present(navigationController, animated: true, completion: nil)
//        vc.modalPresentationStyle = .custom
//        present(vc, animated: true)
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: AllPhoto(),
                title: "All Photo",
                image: UIImage(systemName: "photo")
            ),
            generateVC(
                viewController: SearchVC_One(),
                title: "Search Photo",
                image: UIImage(systemName: "camera.fill")
            ),
            generateVC(
                viewController: Chedevrum(),
                title: "Шедеврум",
                image: UIImage(systemName: "bubble.circle.fill")
            )
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}

