//
//  WelcomeViewController.swift
//  CraftYourProfile
//
//  Created by Дмитрий Константинов on 16.05.2020.
//  Copyright © 2020 Дмитрий Константинов. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    // MARK: Init
    private let viewControllerFactory: ViewControllerFactory

    init(factory: ViewControllerFactory, view: UIView) {

        self.viewControllerFactory = factory
        super.init(nibName: nil, bundle: nil)
        self.view = view
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: WelcomeViewDelegate
extension WelcomeViewController: WelcomeViewDelegate {

    func letsGoButtonTapped() {
        let viewController = viewControllerFactory.makeVerifyPhoneViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }

    func circleButtonTapped() { print(#function) }
    func safariButtonTapped() { print(#function) }
    func homeButtonTapped() { print(#function) }
}