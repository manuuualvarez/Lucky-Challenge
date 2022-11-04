//
//  MainTableViewControllerNavigator.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import UIKit

class MainTableViewControllerNavigator : BaseNavigator {

    private var navigation: UINavigationController? {
        return view?.navigationController
    }

    enum Destination {
        case goToDetail(url: String)
    }

    func navigate(to destination: MainTableViewControllerNavigator.Destination) {
        switch destination {
        case .goToDetail(let url):
            self.navigation?.pushViewController(DetailBusinessBuilder.build(url: url), animated: true)
        }
    }
}
