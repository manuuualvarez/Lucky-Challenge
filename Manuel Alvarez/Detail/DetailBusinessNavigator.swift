//
//  DetailBusinessNavigator.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 02/11/2022.
//

import UIKit

class DetailBusinessNavigator : BaseNavigator {

    private var navigation: UINavigationController? {
        return view?.navigationController
    }

    enum Destination {
        case goBack
    }

    func navigate(to destination: DetailBusinessNavigator.Destination) {
        switch destination {
            case .goBack:
                self.navigation?.popViewController(animated: true)
        }
    }
}
