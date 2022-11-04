//
//  OfferDetailSerivce.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 03/11/2022.
//

import Foundation


class OffersDetailServices {
    
//    MARK: - Request:
    private func fetchNewsRequest(url: String) -> RequestSettings {
        let url: String = url
        
        return RequestConfigurationFactory.createRequestSettings(encodingType: .body,
                                                                 url: url,
                                                                 method: .get)
    }
    
//  MARK: - API Call:
    func getOffersDetails(completion: @escaping(Result<OfferDetail, ServiceError>) -> Void){
//        TODO: Use the service when the API is ready (line 37)
        completion(.success(
            OfferDetail(
                item: Offer.example,
                normalPrice: "EGP500",
                disccountPrice: "EGP500",
                timestampExpiration: 1588100551,
                redemptions: 4,
                isLiked: false,
                offerDescription: "Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery.Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery.Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery.Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery.Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery.Hello this is an app challenge to Lucky App. It is a business that allow you to get Discounts and cashbacks up to 50% from merchants you love in 30+ categories. Pay back in installments up to 60 months & starting 0% interest rate. Save online, in-store and while ordering delivery."
            )
        ))
        
//        APIManager.execute(resource: fetchNewsRequest(), type: OfferDetail.self) { (result) in
//            switch result {
//                case .success(let offersDetail):
//                    completion(.success(offersDetail))
//                case .failure(let error):
//                    completion(.failure(error))
//            }
//        }
    }
}
