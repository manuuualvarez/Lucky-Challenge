//
//  DetailBusinessViewModel.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 02/11/2022.
//

protocol DetailBusinessViewModel: BaseViewModel {
    var offerDetails: LuckyObservable<OfferDetail?> { get }
    func likeButtonDidTap()
    func goBackDidTouch()
}


final class DetailBusinessViewModelImplementation: BaseViewModelImplementation, DetailBusinessViewModel {
    
    // MARK: - Properties
    var navigator: DetailBusinessNavigator?
    
    init(_ url: String) {
        self.url = url
    }
    
    override func viewDidLoad() {
        fetchData()
    }
    // MARK: - Protocol Properties
    let url: String
    var offerDetails: LuckyObservable<OfferDetail?> = LuckyObservable(nil)
    var offerDetailsService = OffersDetailServices()
    
    // MARK: - Protocol Methods
    func goBackDidTouch() {
        navigator?.navigate(to: .goBack)
    }
    
    func likeButtonDidTap() {
        self.offerDetails.value?.isLiked?.toggle()
    }
    
    // MARK: - Private Methods
    
    private func fetchData() {
        offerDetailsService.getOffersDetails { [weak self] (result) in
            switch result {
            case .success(let details):
                self?.offerDetails.value = details
            case .failure(let error):
                print("DEBUG: Error response offers detail \(error)")
            }
        }
    }
}
