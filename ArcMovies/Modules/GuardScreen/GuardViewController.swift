//
//  GuardViewController.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class GuardViewController: UIViewController {
    static var isGuardEnabled = "authenticationEnabled"
    static var isBiometricEnabled = "biometricsEnabled"

    let pinView = PinInputView(with: "Insert your pin", pinSize: 6)

    override func viewDidLoad() {
        self.view.backgroundColor = .navigationColor
        pinView.delegate = self
        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.biometricsEnabled {
            AuthenticationService.shared.askForAuthentication { success in
                if success {
                    RootRouter.presentTabBarController()
                }
            }
        } else {
            pinView.beginUserInput()
        }
    }

    private func setupConstraints() {
        pinView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinView)

        NSLayoutConstraint.activate([
            pinView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            pinView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            pinView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
    }
}

extension GuardViewController: PinInputViewDelegate {
    func didFinishInput(pin: String) {
        print(pin)
        if authenticated() {
            RootRouter.presentTabBarController()
        }
    }

    func authenticated() -> Bool {
        return true
    }
}
