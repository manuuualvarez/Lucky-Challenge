//
//  BusinessEntity.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import Foundation

// MARK: - Response
struct APIData: Decodable {
    let title: String?
    let sections: [Section]?
}

// MARK: - Section
struct Section: Decodable {
    let title: String?
    let items: [Offer]?
}

// MARK: - Offer
struct Offer: Decodable {
    let detailURL, imageURL: String
    let brand, title, tags: String?
    let favoriteCount: Int

    enum CodingKeys: String, CodingKey {
        case detailURL = "detailUrl"
        case imageURL = "imageUrl"
        case brand, title, tags, favoriteCount
    }
    
    var favoriteCountString : String {
         favoriteCount > 1000 ? "\(String(format: "%.1f", Double(favoriteCount)/1000))K" : "\(favoriteCount)"
    }
}

extension Offer {
    static let example = Offer(
        detailURL: "https://www.google.com/",
        imageURL: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1125&h=750&q=80",
        brand: "Burger Joint",
        title: "3,5% Cashbacks Paying with Lucky",
        tags: "Cashback",
        favoriteCount: 283
    )
}


struct OfferDetail: Decodable {
    let item: Offer
    let normalPrice: String?
    let disccountPrice: String?
    let timestampExpiration: Double?
    let redemptions: Int?
    var isLiked: Bool?
    let offerDescription: String?
    
    var dateExpiration: String {
        guard let timestamp = timestampExpiration else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return "Exp.\(formatter.string(from: date))".capitalized
    }
    
}


