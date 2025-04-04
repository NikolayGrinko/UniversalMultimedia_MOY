//
//  ProductAPIService.swift
//  CollectionViewWaldberries
//
//  Created by Николай Гринько on 01.04.2025.
//

import Foundation
import UIKit

struct DummyJSONResponse: Decodable {
    let products: [Produc]
    let total: Int
    let skip: Int
    let limit: Int
}

class ProductAPIService {
    static let shared = ProductAPIService()
    private let session: URLSession
    private let imageCache = NSCache<NSString, UIImage>()
    
    private let baseURL = "https://dummyjson.com/products"
    private let itemsPerPage = 20
    
    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 60
        config.waitsForConnectivity = true
        config.requestCachePolicy = .returnCacheDataElseLoad
        config.urlCache = URLCache(memoryCapacity: 50_000_000,
                                 diskCapacity: 100_000_000,
                                 diskPath: nil)
        session = URLSession(configuration: config)
        
        imageCache.countLimit = 100
        imageCache.totalCostLimit = 50_000_000
    }
    
    func fetchProducts(page: Int, completion: @escaping (Result<(products: [Produc], hasMore: Bool), Error>) -> Void) {
        let skip = page * itemsPerPage
        let urlString = "\(baseURL)?limit=\(itemsPerPage)&skip=\(skip)"
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 30
        request.cachePolicy = .returnCacheDataElseLoad
        
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(DummyJSONResponse.self, from: data)
                let hasMore = (skip + response.products.count) < response.total
                
                DispatchQueue.main.async {
                    completion(.success((products: response.products, hasMore: hasMore)))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            completion(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        session.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self?.imageCache.setObject(image, forKey: urlString as NSString)
            
            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}
