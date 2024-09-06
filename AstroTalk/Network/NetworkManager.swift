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
                                    encoding: ParameterEncoding = URLEncoding.default,
                                    completion: @escaping((T?, String?) -> Void)) {
        let url = NetworkConstant.getUrl(with: endpoint)
        let imageUrl = NetworkConstant.getImageUrl(with: endpoint)
        print(url)
        print(imageUrl)
        AF.request(imageUrl,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: NetworkConstant.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: NetworkConstant.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
}
