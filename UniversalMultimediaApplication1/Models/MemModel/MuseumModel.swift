//
//  MuseumModel.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 30.01.2025.
//

import Foundation

// MARK: - RusMuseum
struct RusMuseum: Decodable {
  //  let elapsedMilliseconds, count: Int
   // let countFacets: CountFacets
    let artObjects: [ArtObject]
   // let facets: [RusMuseumFacet]
}

// MARK: - ArtObject
struct ArtObject: Decodable {
   // let links: Links
    let id, title: String?
    let hasImage: Bool
   // let principalOrFirstMaker: PrincipalOrFirstMaker
    let longTitle: String?
   // let showImage, permitDownload: Bool
    let webImage: Image?
    let productionPlaces: [String]
}

// MARK: - Image
struct Image: Decodable {
    let guid: String?
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String?
}


// MARK: - Links
//struct Links: Codable {
//    let linksSelf, web: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case web
//    }
//}

//enum PrincipalOrFirstMaker: String, Codable {
//    case rembrandtVanRijn = "Rembrandt van Rijn"
//}

// MARK: - CountFacets
//struct CountFacets: Codable {
//    let hasimage, ondisplay: Int
//}

// MARK: - RusMuseumFacet
//struct RusMuseumFacet: Codable {
//    let facets: [FacetFacet]
//    let name: String
//    let otherTerms, prettyName: Int
//}

//// MARK: - FacetFacet
//struct FacetFacet: Codable {
//    let key: String
//    let value: Int
//}
class MuseumModel {
    
    private var apiService = ApiReq_1TB()
    private var popularMuseum = [ArtObject]()
    
    func fetchPopularMoviesData(completion: @escaping (String?) -> ()) {
        
        // weak self - prevent retain cycles
        apiService.getPopularMoviesDatas { [weak self] result in
            
//            switch result {
//            case .success(let listOf):
//                self?.popularMuseum = listOf.artObject
//                completion(nil)
//            case .failure(let error):
//                // Something is wrong with the JSON file or the model
//                print("Error processing json data: \(error)")
//            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        if popularMuseum.count != 0 {
            return popularMuseum.count
        }
        return 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> ArtObject {
        return popularMuseum[indexPath.row]
    }
    
}
