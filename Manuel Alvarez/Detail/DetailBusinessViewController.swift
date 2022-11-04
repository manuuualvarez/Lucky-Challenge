//
//  DetailBusinessViewController.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 02/11/2022.
//

import UIKit
import Kingfisher

class DetailBusinessViewController: BaseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var imageContainer: UIView!
    @IBOutlet weak var offerImage: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var ratingValuesLabel: UILabel!
    @IBOutlet weak var offerTitle: UILabel!
    @IBOutlet weak var descriptionOfferTextView: UITextView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var expirationDateLabel: UILabel!
    @IBOutlet weak var normalPriceLabel: UILabel!
    @IBOutlet weak var priceWithDiscountLabel: UILabel!
    @IBOutlet weak var redemptionsLabel: UILabel!
    
    var viewModel: DetailBusinessViewModel!
    override var baseViewModel: BaseViewModel {
        return viewModel
    }
    
    let heart = UIImageView(frame: CGRect(x: 0, y: 0, width: 41.97, height: 41.83))

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCoverImage()
        setupLabels()
        setupDescriptionTextView()
        configureBackBarItem()
        configureLikeBarItem()
        configureHeart()
        bind()
    }
    // MARK: - Methods
    private func bind() {
        viewModel.offerDetails.observe(on: self) { [weak self] _ in
            self?.configureLikeBarItem()
        }
    }
    
    private func setupCoverImage() {
        if let url = URL(string: viewModel.offerDetails.value?.item.imageURL ?? "") {
            offerImage.kf.setImage(with: url, placeholder: UIImage(named: "Empty-Image"))
        } else {
            offerImage.image = UIImage(named: "Empty-Image")
        }
    }
    
    private func setupLabels() {
        businessNameLabel.text = viewModel.offerDetails.value?.item.brand?.uppercased()
        businessNameLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        businessNameLabel.textColor = .lightLuckyGray

        ratingValuesLabel.text = viewModel.offerDetails.value?.item.favoriteCountString
        ratingValuesLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        ratingValuesLabel.textColor = .lightLuckyGray

        offerTitle.text = viewModel.offerDetails.value?.item.title
        offerTitle.font = UIFont.systemFont(ofSize: 32, weight: .medium)
        offerTitle.textColor = .strongTitle
        
        priceTitleLabel.text = "PRICE"
        priceTitleLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        priceTitleLabel.textColor = UIColor(red: 0.13, green: 0.18, blue: 0.1, alpha: 1)
        
        expirationDateLabel.text = viewModel.offerDetails.value?.dateExpiration
        expirationDateLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        expirationDateLabel.textColor = .lightLuckyGray
        
        normalPriceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        normalPriceLabel.textColor = UIColor(red: 0.61, green: 0.69, blue: 0.74, alpha: 1)
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: viewModel.offerDetails.value?.normalPrice ?? "")
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        normalPriceLabel.attributedText = attributeString

        priceWithDiscountLabel.text = viewModel.offerDetails.value?.disccountPrice
        priceWithDiscountLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        priceWithDiscountLabel.textColor = .strongTitle
        
        redemptionsLabel.text = "REDEMPTIONS CAP: \(viewModel.offerDetails.value?.redemptions ?? 0) TIMES"
        redemptionsLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        redemptionsLabel.textColor = .strongTitle
        
    }
    
    private func setupDescriptionTextView(){
        self.descriptionOfferTextView.text = viewModel.offerDetails.value?.offerDescription
        descriptionOfferTextView.textContainerInset = .zero
        descriptionOfferTextView.font = UIFont.systemFont(ofSize: 16, weight: .light)
    }
    
    private func configureLikeBarItem() {
        self.navigationController?.navigationBar.barTintColor = .black
        let rightImage = viewModel.offerDetails.value?.isLiked ?? false ? UIImage(named: "heart-fill") : UIImage(named: "heart-empty")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(likeButtonDidTap))
        
        if self.viewModel.offerDetails.value?.isLiked ?? false {
            self.animateHeart()
        }
    }
    
    private func configureBackBarItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ChevronBack"), style: .plain, target: self, action: #selector(goBack))
    }
    
    private func configureHeart() {
        heart.image = UIImage(named: "white-heart")
        heart.center = imageContainer.center
        imageContainer.addSubview(heart)
        heart.alpha = 0
    }
    
    private func animateHeart() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.heart.alpha = 1.0
        self.heart.center = self.imageContainer.center
        UIView.animate(withDuration: 2) {
            self.heart.frame.size = CGSize(width: 71.95, height: 71.71)
            self.heart.center = self.imageContainer.center
        } completion: { _ in
            self.heart.alpha = 0.0
            self.heart.frame.size = CGSize(width: 41.97, height: 41.83)
            self.heart.center = self.imageContainer.center
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    
    @objc private func likeButtonDidTap() {
        viewModel.likeButtonDidTap()
    }
    
    @objc private func goBack() {
        viewModel.goBackDidTouch()
    }
}
