//
//  NetworkManager.swift
//  Media
//
//  Created by 조규연 on 6/21/24.
//

import Foundation
import Alamofire

class NetworkManager {
    private init() { }
    static let shared = NetworkManager()
    
    func getMovieData<T: Decodable>(api: TMDBAPI, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .responseDecodable(of: responseType) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
