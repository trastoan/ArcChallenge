//
//  GuardViewController.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class GuardViewController: UIViewController {
    let pinView = PinInputView(frame: .zero)


    override func viewDidLoad() {
        self.view.backgroundColor = .navigationColor
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        AuthenticationService.shared.askForAuthentication { success in
//            if success {
//                RootRouter.presentTabBarController()
//            }
//        }
    }

    private func setupConstraints() {
        pinView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinView)

        NSLayoutConstraint.activate([
            pinView.heightAnchor.constraint(equalToConstant: 60),
            pinView.widthAnchor.constraint(equalToConstant: 150),
            pinView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            pinView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}
