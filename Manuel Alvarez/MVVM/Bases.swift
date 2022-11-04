//
//  Bases.swift
//  Manuel Alvarez
//
//  Created by Manny Alvarez on 01/11/2022.
//

import UIKit

// MARK: - Base ViewController
class BaseViewController: UIViewController {
    
    var baseViewModel: BaseViewModel?  {
        return nil
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        baseViewModel?.viewDidLoad()
        configureNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        baseViewModel?.viewDidAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        baseViewModel?.viewWillAppear()
    }
    
    func setupToEndEditingOnTap(delegate: UIGestureRecognizerDelegate? = nil) {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(view.finishEditing))
        tap.cancelsTouchesInView = false
        tap.delegate = delegate
        view.addGestureRecognizer(tap)
    }
    
    func configureNavBar() {
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithOpaqueBackground()
            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
            navBarAppearance.backgroundColor = .lightGrayBackground
            navBarAppearance.shadowColor = .clear
            self.navigationController?.navigationBar.standardAppearance = navBarAppearance
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
}

// MARK: - BaseViewModel
protocol BaseViewModel {
    func viewDidLoad()
    func viewDidAppear()
    func viewWillAppear()
}

class BaseViewModelImplementation: NSObject, BaseViewModel {
    func viewWillAppear() {}
    func viewDidLoad() {}
    func viewDidAppear() {}
}

// MARK: - Base Navigator
class BaseNavigator {
    weak var view: UIViewController?
}
