//
//  MainTableViewControllerViewController.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import UIKit

private let reuseIdentifier = "OfferTableViewCell"

class MainTableViewControllerViewController: BaseViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var offersCountLabel: UILabel!
    @IBOutlet weak var offersCountTopConstraint: NSLayoutConstraint!
    
    var viewModel: MainTableViewControllerViewModel!
    override var baseViewModel: BaseViewModel {
        return viewModel
    }
    
    // MARK: - Properties
    let searchController = UISearchController()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setUpTableView()
        setupUI()
        setupNavigationBar()
        configureSearchBar()
    }
        
    // MARK: - Observed method
    private func bind() {
        viewModel.data.observe(on: self) { [weak self] _ in
            self?.mainTableView.reloadData()
            self?.setupUI()
        }
        viewModel.navigationStatus.observe(on: self) { [weak self] status in
            self?.setupNavigationBar()
            self?.offersCountLabel.text = self?.viewModel.getOfferItems()
            self?.mainTableView.reloadData()
            self?.title = status == .normal ? "Title" : ""
        }
        viewModel.filteredOffers.observe(on: self) { [weak self] _ in
            if self?.viewModel.navigationStatus.value ==  .searchActive {
                self?.offersCountLabel.text = self?.viewModel.getOfferItems()
                self?.mainTableView.reloadData()
            }
        }
    }
    
    // MARK: - Methods
    private func setUpTableView() {
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.backgroundColor = .white
        self.mainTableView.separatorStyle = .none
        
        self.mainTableView.translatesAutoresizingMaskIntoConstraints = false
        self.mainTableView.register(OfferTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(mainTableView)
    }
        
    private func setupUI() {
        self.offersCountLabel.text = viewModel.getOfferItems()
        self.offersCountLabel.textColor = .lightLuckyGray
        self.offersCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    private func setupNavigationBar() {
        switch viewModel.navigationStatus.value {
            case .normal:
                let searchBtn = UIBarButtonItem(image: UIImage(named: "SearchIcon"), style: .plain, target: self, action: #selector (searchIconDidTap))
                self.navigationItem.rightBarButtonItem = searchBtn
            self.navigationController?.navigationBar.topItem?.searchController?.searchBar.isHidden = true
            case .searchActive:
                searchController.isActive = true
                setupSearchBar()
        }
    }
    
    private func setupSearchBar() {
        self.view.addSubview(searchController.searchBar)
        searchController.searchBar.becomeFirstResponder()
        offersCountTopConstraint.constant = self.searchController.searchBar.frame.height + 14
    }
    
    private func configureSearchBar() {
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.barTintColor = .lightGrayBackground
        self.searchController.searchBar.layer.shadowColor = UIColor.clear.cgColor
    }
    
    // MARK: - Selectors
    @objc func searchIconDidTap() {
        viewModel.navigationStatus.value = .searchActive
    }
}

    // MARK: - Extensions
extension MainTableViewControllerViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.navigationStatus.value == .searchActive  ? 1 : viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.navigationStatus.value == .searchActive ? viewModel.filteredOffers.value.count : viewModel.getSectionItems(section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let businessCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OfferTableViewCell
        
        let data = viewModel.navigationStatus.value == .searchActive ? viewModel.filteredOffers.value[indexPath.row] : viewModel.getItem(section: indexPath.section, item: indexPath.item)
        if let businessData =  data {
            businessCell.setUpCell(businessData)
            businessCell.backgroundColor = .white
        }
        return businessCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if viewModel.navigationStatus.value != .searchActive {
            let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: mainTableView.frame.width, height: 70))
            let title = UILabel()
            
            title.frame = CGRect.init(x: 24, y: 0, width: headerView.frame.width, height: headerView.frame.height-24)
            title.text = viewModel.getSectionTitle(section)
            title.font = UIFont.systemFont(ofSize: 24, weight: .medium)
            title.textColor = .headerTitle
            
            headerView.addSubview(title)
            
            return headerView
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        viewModel.navigationStatus.value == .searchActive ? 0 : 70
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        viewModel.navigationStatus.value = .normal
        viewModel.showBusinessDetail(indexPath)
    }
}

// MARK: - Search Bar
extension MainTableViewControllerViewController: UISearchResultsUpdating, UISearchBarDelegate, UISearchControllerDelegate {

    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else {
            return
        }
        viewModel.filterItems(filter)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.navigationStatus.value = .normal
        offersCountTopConstraint.constant = 14
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        searchController.searchBar.becomeFirstResponder()
    }
}
