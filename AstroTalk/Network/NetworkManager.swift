//
//  NetworkManager.swift
//  AstroTalk
//
//  Created by Aisha on 05.09.24.
//

import Foundation
import Alamofire


class NetworkManager {
   
    static func request<T: Codable>(model: T.Type,
                                    endpoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    isEncodingNeeded: Bool = false,
                                    completion: @escaping((T?, String?) -> Void)) {
       
        let url = NetworkConstant.getUrl(with: endpoint)
        print(url)
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: isEncodingNeeded ? JSONEncoding.default : URLEncoding.default,
                   headers: NetworkConstant.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let model):
                completion(model, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
}
