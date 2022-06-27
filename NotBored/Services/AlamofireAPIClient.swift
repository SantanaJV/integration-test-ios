//
//  AlamofireAPIClient.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 24/06/22.
//

import Foundation
import Alamofire

class AlamofireAPIClient {
    func get(_ url: String, parameters: Parameters?, completion: @escaping (Result<Data?, AFError>) -> Void) {
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { response in
            completion(response.result)
        }
    }
}
