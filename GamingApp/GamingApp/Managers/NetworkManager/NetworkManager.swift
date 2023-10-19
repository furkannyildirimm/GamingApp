//
//  NetworkManager.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import Alamofire
import Foundation

final class NetworkManager {
    static let shared = NetworkManager()

    func fetchGameDetails<T: Decodable>(gameId: String, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(Constants.apiBaseURL.rawValue)games/\(gameId)\(Constants.jsonApiKey.rawValue)\(Constants.apiKey.rawValue)"
        print(url)
        AF.request(url).responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        } 
    }

    func fetchGameList<T: Decodable>(_ pageNumber: Int, completion: @escaping (Result<T, Error>) -> Void) {
        let url = "\(Constants.apiBaseURL.rawValue)games\(Constants.jsonApiKey.rawValue)\(Constants.apiKey.rawValue)\(pageNumber)"
        AF.request(url).responseDecodable(of: T.self, decoder: JSONDecoder()) { response in
            switch response.result {
            case .success(let result):
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}




