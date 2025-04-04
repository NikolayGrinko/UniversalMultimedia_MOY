import UIKit

class ProductPageViewController: UIPageViewController {
    private var currentPage = 0
    private var isLoading = false
    private var hasMoreProducts = true
    private var products: [Produc] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        loadNextPage()
    }
    
    private func loadNextPage() {
        guard !isLoading, hasMoreProducts else { return }
        isLoading = true
        
        ProductAPIService.shared.fetchProducts(page: currentPage) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.products.append(contentsOf: response.products)
                self.hasMoreProducts = response.hasMore
                self.currentPage += 1
                
                if self.viewControllers?.isEmpty ?? true {
                    if let firstVC = self.viewControllerForIndex(0) {
                        self.setViewControllers([firstVC], direction: .forward, animated: false)
                    }
                }
                
            case .failure(let error):
                print("Error loading products: \(error)")
            }
        }
    }
    
    private func viewControllerForIndex(_ index: Int) -> UIViewController? {
        guard index >= 0, index < products.count else { return nil }
        
        let productVC = ProductDetailViewController()
        productVC.product = products[index]
        productVC.index = index
        return productVC
    }
}

extension ProductPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let productVC = viewController as? ProductDetailViewController else { return nil }
        return viewControllerForIndex(productVC.index - 1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let productVC = viewController as? ProductDetailViewController else { return nil }
        let nextIndex = productVC.index + 1
        
        if nextIndex >= products.count - 5 {
            loadNextPage()
        }
        
        return viewControllerForIndex(nextIndex)
    }
}