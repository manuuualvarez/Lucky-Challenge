//
//  MainTableViewControllerViewModel.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import Foundation

enum NavigationBarType {
    case searchActive
    case normal
}

protocol MainTableViewControllerViewModel: BaseViewModel {
    var data: LuckyObservable<APIData?> { get }
    var filteredOffers: LuckyObservable<[Offer]> { get  }
    var navigationStatus: LuckyObservable<NavigationBarType> { get set }
    var numberOfSections: Int { get }
    func getSectionTitle(_ section: Int) -> String
    func getSectionItems(_ section: Int) -> [Offer]?
    func getOfferItems() -> String
    func getItem(section: Int, item: Int) -> Offer?
    func filterItems(_ filter: String)
    func showBusinessDetail(_ indexPath: IndexPath)
}

final class MainTableViewControllerViewModelImplementation: BaseViewModelImplementation, MainTableViewControllerViewModel {
    
    // MARK: - Properties
    var navigator: MainTableViewControllerNavigator?
    var numberOfSections: Int {
        return self.data.value?.sections?.count ?? 0
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        fetchData()
    }
    
    // MARK: - Services
    var offersServices = OffersServices()
    
    // MARK: - Protocol Properties
    var data: LuckyObservable<APIData?> = LuckyObservable(nil)
    var filteredOffers: LuckyObservable<[Offer]> = LuckyObservable([])
    var navigationStatus: LuckyObservable<NavigationBarType> = LuckyObservable(.normal)
    
    // MARK: - Protocol Methods
    func getSectionTitle(_ section: Int) -> String {
        guard let title = self.data.value?.sections?[section].title  else { return "Failed title" }
        return title
    }
    
    func getSectionItems(_ section: Int) -> [Offer]? {
        guard let business = self.data.value?.sections?[section].items  else { return nil }
        return business
    }
    
    func getOfferItems() -> String {
        switch self.navigationStatus.value {
            case .normal:
                if let items = data.value?.sections?.compactMap({ $0.items }).reduce(0, { $0 + $1.count }) {
                    return "\(items) \(items > 1 ? "offers" : "offer")"
                } else {
                    return "Empty result"
                }
            case .searchActive:
            return  "\(filteredOffers.value.count) \(filteredOffers.value.count > 1 ? "offers" : "offer")"
        }

    }
    
    func getItem(section: Int, item: Int) -> Offer? {
        return data.value?.sections?[section].items?[item]
    }
    
    func filterItems(_ filter: String) {
        var filteredData: [Offer] = []
        data.value?.sections?.forEach{ sections in
            for item in sections.items ?? [] {
                guard let title = item.title, let tag = item.tags else { return  }
                if title.contains(filter) || tag.contains(filter) {
                    filteredData.append(item)
                }
            }
        }
        self.filteredOffers.value = filteredData
    }
    
    // MARK: - Private Methods
    private func fetchData() {
        offersServices.getOffers { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.data.value = data
            case .failure(_):
                print("DEBUG: -> Error Fail")
            }
        }
    }
    
    //MARK: - Navigations
    func showBusinessDetail(_ indexPath: IndexPath) {
        switch navigationStatus.value  {
        case .normal:
            guard let offer = self.getItem(section: indexPath.section, item: indexPath.item) else { return }
            self.navigator?.navigate(to: .goToDetail(url: offer.detailURL))
        case .searchActive:
            self.navigator?.navigate(to: .goToDetail(url: filteredOffers.value[indexPath.item].detailURL))
        }
    }
    
}
