//
//  DetailBusinessBuilder.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 02/11/2022.
//

import Foundation

class DetailBusinessBuilder {
    static func build(url: String) -> DetailBusinessViewController {
        let viewModel = DetailBusinessViewModelImplementation(url)
        let controller = DetailBusinessViewController()
        let navigator = DetailBusinessNavigator()

        navigator.view = controller

        viewModel.navigator = navigator

        controller.viewModel = viewModel
        return controller
    }
}
