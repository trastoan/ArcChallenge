//
//  GuardViewController.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class GuardViewController: UIViewController {
    var model: GuardViewModel!

    let pinView = PinInputView(with: "Insert your pin", pinSize: 6)

    override func viewDidLoad() {
        self.view.backgroundColor = .navigationColor
        title = "Insert Your pin"
        pinView.delegate = self

        model.defaultAuthentication = { [weak self] in
            self?.pinView.beginUserInput()
        }
        model.failedToAuthenticate = { [weak self] in
            self?.authFailed()
        }

        setupConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        model.authenticateUser()
    }

    private func setupConstraints() {
        pinView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pinView)

        NSLayoutConstraint.activate([
            pinView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 18),
            pinView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -18),
            pinView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -80)
        ])
    }

    private func authFailed() {
        UIView.animate(withDuration: 1) {
            self.view.backgroundColor = .systemRed
            self.pinView.changeMessage("Wrong pin")
        } completion: { _ in
            self.view.backgroundColor = .navigationColor
            self.pinView.beginUserInput()
            self.pinView.changeMessage("Insert your pin")
        }

    }
}

extension GuardViewController: PinInputViewDelegate {
    func didFinishInput(_ inputView: PinInputView, pin: String) {
        model.pinAuthentication(passcode: pin)
    }
}
