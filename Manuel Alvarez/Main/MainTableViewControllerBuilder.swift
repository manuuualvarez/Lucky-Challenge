//
//  MainTableViewControllerBuilder.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import UIKit

class MainTableViewControllerBuilder {
    static func build() -> MainTableViewControllerViewController? {
        let viewModel = MainTableViewControllerViewModelImplementation()
        guard let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTableViewControllerViewController") as? MainTableViewControllerViewController else { return nil }
        let navigator = MainTableViewControllerNavigator()

        navigator.view = controller

        viewModel.navigator = navigator

        controller.viewModel = viewModel
        return controller
    }
}
