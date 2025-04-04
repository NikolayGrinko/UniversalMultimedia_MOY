//
//  Wildberr_1.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 02.04.2025.
//

import UIKit
import SkeletonView

class Wildberries_1: UIViewController {
    
    private var produc: [Produc] = [] {
        didSet {
            print("Products array updated. Count: \(produc.count)")
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isSkeletonable = true
        return cv
    }()
    
    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "cart"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupUI()
        setupCartButton()
        
        let gradient = SkeletonGradient(
            baseColor: UIColor(red: 0.62, green: 0.1, blue: 0.41, alpha: 1),
            secondaryColor: UIColor(red: 0.06, green: 0, blue: 0.19, alpha: 1)
        )
        
        collectionView.showAnimatedGradientSkeleton(
            usingGradient: gradient,
            animation: SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight),
            transition: .crossDissolve(0.75)
            
        )
        
        view.showAnimatedGradientSkeleton(
            usingGradient: gradient,
            animation: SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight),
            transition: .crossDissolve(0.75)
            )
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            self.fetchProduct()
        }
        
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(handleCartUpdate),
                                             name: .cartDidUpdate,
                                             object: nil)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
        ]
        
        navigationController?.navigationBar.titleTextAttributes = attributes
        title = "Товары"
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
            appearance.titleTextAttributes = attributes
            appearance.shadowColor = .clear
            
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            
            navigationController?.navigationBar.tintColor = .white
        } else {
            navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.6240465045, green: 0.09995300323, blue: 0.4080937505, alpha: 1)
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.titleTextAttributes = attributes
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationController?.navigationBar.shadowImage = UIImage()
        }
        
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setupUI() {
        view.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        
        collectionView.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        activityIndicator.color = .white
        
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        collectionView.isSkeletonable = true
        view.isSkeletonable = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupCartButton() {
        let cartBarButton = UIBarButtonItem(customView: cartButton)
        navigationItem.rightBarButtonItem = cartBarButton
        cartButton.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        updateCartBadge()
    }
    
    @objc private func updateCartBadge() {
        let totalItems = CartManager.shared.totalItems
        if totalItems > 0 {
            cartButton.setTitle(" \(totalItems)", for: .normal)
        } else {
            cartButton.setTitle(nil, for: .normal)
        }
    }
    
    @objc private func handleCartUpdate() {
        updateCartBadge()
        collectionView.visibleCells.forEach { cell in
            if let productCell = cell as? ProductCell {
                productCell.updateBuyButton()
            }
        }
    }
    
    @objc private func cartButtonTapped() {
        let cartVC = CartViewController()
        navigationController?.pushViewController(cartVC, animated: true)
    }
    
    @objc private func refreshData() {
        print("Refreshing data...")
        fetchProduct()
    }
    
    private func fetchProduct() {
        showLoading(true)
        
        ProductAPIService.shared.fetchProducts(page: 0) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.showLoading(false)
                
                switch result {
                case .success(let response):
                    self.produc = response.products // Using products directly from response
                    
                    self.view.stopSkeletonAnimation()
                    self.view.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.9))
                    
                    self.collectionView.stopSkeletonAnimation()
                    self.collectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.9))
                    
                    UIView.transition(with: self.collectionView,
                                    duration: 0.3,
                                    options: .transitionCrossDissolve,
                                    animations: {
                        self.collectionView.reloadData()
                    })
                    
                    if self.produc.isEmpty {
                        self.showEmptyState()
                    } else {
                        self.collectionView.backgroundView = nil
                    }
                    
                case .failure(let error):
                    print("Error fetching products: \(error)")
                    self.showError()
                }
            }
        }
    }
    
    private func showLoading(_ show: Bool) {
        if show {
            activityIndicator.startAnimating()
            collectionView.refreshControl?.beginRefreshing()
        } else {
            activityIndicator.stopAnimating()
            collectionView.refreshControl?.endRefreshing()
        }
    }
    
    private func showError() {
        let alert = UIAlertController(
            title: "Ошибка загрузки",
            message: "Не удалось загрузить данные. Проверьте подключение к интернету и попробуйте снова.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            self?.fetchProduct()
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showEmptyState() {
        let label = UILabel()
        label.text = "Нет доступных товаров"
        label.textAlignment = .center
        label.textColor = .gray
        collectionView.backgroundView = label
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension Wildberries_1: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10 // Количество ячеек-скелетонов
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ProductCell.reuseId
    }
}

extension Wildberries_1: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = produc.count
        print("numberOfItemsInSection called: \(count) items")
        collectionView.backgroundView?.isHidden = !produc.isEmpty
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.configure(with: produc[indexPath.item])
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / 2
        return CGSize(width: width, height: width * 1.7)
    }
}

// MARK: - ProductCellDelegate
extension Wildberries_1: ProductCellDelegate {
    func didTapProductCell(_ cell: ProductCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let product = produc[indexPath.item]
        let detailVC = DetailViewController(product: product)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
