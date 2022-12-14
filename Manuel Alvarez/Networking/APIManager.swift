//
//  APIManager.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import Foundation
import Alamofire

class APIManager {
    
    static func execute<T: Decodable>(resource: ResourceProtocol,type: T.Type, completion: @escaping(Result<T, ServiceError>) -> Void) {
        
        makeRequest(resource: resource, type: T.self, completion: completion)
    }
    
    static func makeRequest<T: Decodable>(resource: ResourceProtocol, type: T.Type, completion: @escaping(Result<T, ServiceError>) -> Void ){
        AF.request(resource.url, method: resource.method).validate().responseData(completionHandler: { response in
            
            guard let value = response.data else {
                let error = ServiceError.genericError
                completion(.failure(error))
                return
            }
            
            switch response.result {
                case .success:
                    do {
                        let object = try JSONDecoder().decode(T.self, from: value)
                        completion(.success(object))
                    } catch {
                        let error = ServiceError.genericError
                        completion(.failure(error))
                    }
                case .failure(_):
                    let error = ServiceError.genericError
                    completion(.failure(error))
            }
        })
    }
}

