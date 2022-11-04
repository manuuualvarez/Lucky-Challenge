//
//  BusinessServices.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import Foundation


class OffersServices {
    
//    MARK: - Request:
    private func fetchNewsRequest() -> RequestSettings {
        let url: String = "https://my-json-server.typicode.com/mluksenberg/lucky-test/test"
        
        return RequestConfigurationFactory.createRequestSettings(encodingType: .body,
                                                                 url: url,
                                                                 method: .get)
    }
    
//  MARK: - API Call:
    func getOffers(completion: @escaping(Result<APIData, ServiceError>) -> Void){
        APIManager.execute(resource: fetchNewsRequest(), type: APIData.self) { (result) in
            switch result {
                case .success(let offers):
                    completion(.success(offers))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
