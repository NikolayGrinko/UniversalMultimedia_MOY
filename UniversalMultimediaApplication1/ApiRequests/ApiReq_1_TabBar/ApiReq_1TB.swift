//
//  ApiReq_1TB.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 21.01.2025.
//

import Foundation

class ApiReq_1TB {
    
    // static let shared = ApiReq_1TB()
    
    //    func downloadGets() {
    //
    //        guard let url =  URL(string:"https://api.giphy.com/v1/gifs/random?api_key=52XDHS8G0DDhvq9SiF8SXkLnCzdTbj28&tag=&rating=g") else { return }
    //
    //        let session = URLSession.shared
    //        session.dataTask(with: url) { data, response, error in
    //            if let response = response {
    //               // print(response)
    //            }
    //            guard let data = data else { return }
    //           // print(data)
    //            do {
    //                let json = try JSONSerialization.jsonObject(with: data, options: [])
    //                print(json)
    //            } catch {
    //                print(error)
    //            }
    //        }.resume()
    //    }
    //
    
    private var dataTask: URLSessionDataTask?
    
    func getPopularMoviesDatas(completion: @escaping (Result) -> Void) {
        
        let popularMoviesURL = "https://api.themoviedb.org/3/movie/popular?api_key=4e0be2c22f7268edffde97481d49064a&language=en-US&page=1"
        
        guard let url = URL(string: popularMoviesURL) else {return}
        
        // Create URL Session - work on the background
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Handle Error
            if let error = error {
               // completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                // Handle Empty Response
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                // Handle Empty Data
                print("Empty Data")
                return
            }
            
            do {
                // Parse the data
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RusMuseum.self, from: data)
                print(jsonData)
                // Back to the main thread
                DispatchQueue.main.async {
                   // completion(.success(jsonData))
                }
            } catch let error {
               // completion(.failure(error))
            }
            
        }
        dataTask?.resume()
    }
}
  //  func downloadMuseum() {
        
//        guard let url =  URL(string:"https://www.rijksmuseum.nl/api/nl/collection?key=22Q0fdS2&involvedMaker=Rembrandt+van+Rijn") else { return }
//        
//        let session = URLSession.shared
//        session.dataTask(with: url) { data, response, error in
//            if let response = response {
//               // print(response)
//            }
//            guard let data = data else { return }
//           // print(data)
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print(error)
//            }
//        }.resume()
  //  }
