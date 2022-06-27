//
//  ActivitiesService.swift
//  NotBored
//
//  Created by Joao Victor Santana Santos on 24/06/22.
//

import Foundation
import Alamofire

class ActivitiesService {
    let apiClient = AlamofireAPIClient()
    
    func getActivity(queryOptions: ActivityQueryOptions?, completion: @escaping (Activity?, String?) -> Void) {
        let url = "http://www.boredapi.com/api/activity"
        var parameters: Parameters?
        
        if let queryOptions = queryOptions {
            parameters = [
                "participants": queryOptions.participants ?? "",
                "type": queryOptions.type ?? "",
                "minprice": queryOptions.minimumPrice,
                "maxprice": queryOptions.maximumPrice
            ]
        }
        
        apiClient.get(url, parameters: parameters) { result in
            switch (result) {
            case .success(let data):
                do {
                    let decodedActivity = try JSONDecoder().decode(Activity.self, from: data!)
                    completion(decodedActivity, nil)
                } catch {
                    completion(nil, "We did not find any activities following the given query options")
                }
            case.failure( _):
                completion(nil, "Error during request. Check your internet connection")
            }
            
        }
        
    }
}
