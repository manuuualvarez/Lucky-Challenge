//
//  BusinessCell.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import UIKit
import Kingfisher


class OfferTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var offer: Offer?
    
    //MARK: - UI
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .strongTitle
        return label
    }()
    
    private let offerImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
       let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.distribution = .fillProportionally
        return vStack
    }()
    
    private let detailsStackView: UIStackView = {
        let hStack = UIStackView()
         hStack.axis = .horizontal
         hStack.distribution = .fill
        hStack.alignment = .leading
         return hStack
    }()
    
    private let businessNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .lightLuckyGray
        return label
    }()
    
    private let ratingStackView: UIStackView = {
        let hStack = UIStackView()
         hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
         hStack.alignment = .trailing
         return hStack
    }()
    
    private let ratingImageHeart: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Hearth")
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .lightLuckyGray
        return label
    }()
    
    private var tagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = .lightLuckyGray
        return label
    }()
    
//MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        addSubview(offerImage)
        offerImage.anchor(top: self.topAnchor, left: self.leftAnchor, paddingTop: 0, paddingLeft: 24, width: 120, height: 80)
        offerImage.clipsToBounds = true
        
        addSubview(mainStackView)
        mainStackView.anchor(top: self.topAnchor, left: offerImage.rightAnchor, right: self.rightAnchor, paddingTop: 0, paddingLeft: 16, paddingRight: 23, height: 80)
        
        mainStackView.addSubview(detailsStackView)
        
        detailsStackView.anchor(top: self.mainStackView.topAnchor, left: self.mainStackView.leftAnchor, right: self.mainStackView.rightAnchor, height: 12)
        detailsStackView.addSubview(businessNameLabel)
        
        businessNameLabel.anchor(top: self.detailsStackView.topAnchor, left: self.detailsStackView.leftAnchor)
        
        detailsStackView.addSubview(ratingStackView)

        ratingStackView.addSubview(ratingImageHeart)
        ratingStackView.addSubview(ratingLabel)
        ratingStackView.anchor(top: detailsStackView.topAnchor, left: businessNameLabel.rightAnchor, right: detailsStackView.rightAnchor, height: 12)
        
        ratingLabel.anchor(top: self.ratingStackView.topAnchor, right: self.ratingStackView.rightAnchor, height: 12)
        ratingImageHeart.anchor(right: ratingLabel.leftAnchor, paddingRight: 5.38, width: 8.24, height: 8.27)
        ratingImageHeart.centerY(inView: ratingStackView)
        
        mainStackView.addSubview(mainLabel)
        mainLabel.centerY(inView: mainStackView)
        mainLabel.anchor(left: self.mainStackView.leftAnchor,  right: self.mainStackView.rightAnchor)
        
        mainStackView.addSubview(tagLabel)
        tagLabel.anchor(left: self.mainStackView.leftAnchor, bottom: self.mainStackView.bottomAnchor, right: self.mainStackView.rightAnchor)
    }
    
    func setUpCell(_ offer: Offer) {
        self.offer = offer
        setupBackgroundImage()
        mainLabel.text = offer.title
        businessNameLabel.text = offer.brand?.uppercased()
        ratingLabel.text = offer.favoriteCountString
        tagLabel.text = offer.tags
    }
    
    private func setupBackgroundImage() {
        if let image = offer?.imageURL, let url = URL(string: image) {
            offerImage.kf.setImage(with: url, placeholder: UIImage(named: "Empty-Image"))
        } else {
            offerImage.image = UIImage(named: "Empty-Image")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
}

