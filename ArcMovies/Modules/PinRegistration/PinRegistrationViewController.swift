//
//  PinRegistrationViewController.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class PinRegistrationViewController: UIViewController {
    var model: PinRegistrationViewModel!

    private let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.isUserInteractionEnabled = false
        scroll.backgroundColor = .navigationColor

        return scroll
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()

    private let pinView = PinInputView(with: "Choose Your Pin", pinSize: 6)
    private let confirmationPinView = PinInputView(with: "Repeat Your Pin", pinSize: 6)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pin Registration"

        setupCancelButton()
        setupConstraints()
        model.failedConfirmation = {
            self.wrongConfirmation()
        }

        pinView.delegate = self
        confirmationPinView.delegate = self

        pinView.beginUserInput()
    }

    private func setupConstraints() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(pinView)
        contentView.addSubview(confirmationPinView)

        pinView.translatesAutoresizingMaskIntoConstraints = false
        confirmationPinView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.centerOnSelf(view: self.view)

        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 2),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),

            pinView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pinView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
            pinView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),

            confirmationPinView.leadingAnchor.constraint(equalTo: pinView.trailingAnchor),
            confirmationPinView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            confirmationPinView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -100),
        ])
    }

    private func setupCancelButton() {
        let action = UIAction { [weak self] _ in self?.model.cancelRegistration() }
        let barButton = UIBarButtonItem(systemItem: .cancel, primaryAction: action)
        barButton.tintColor = .white

        navigationItem.setRightBarButton(barButton, animated: false)
    }

    private func wrongConfirmation() {
        UIView.animate(withDuration: 0.5) {
            self.scrollView.backgroundColor = .systemRed
            self.confirmationPinView.changeMessage("Pin doesn't match")
        } completion: { _ in
            self.scrollView.backgroundColor = .navigationColor
            self.confirmationPinView.changeMessage("Repeat your pin")
            self.scrollToBegin()
        }

    }

    private func scrollToBegin() {
        let y = scrollView.contentOffset.y

        scrollView.setContentOffset(CGPoint(x: 0, y: y), animated: true)
        pinView.beginUserInput()
    }

    private func scrollToConfirmation() {
        let x = contentView.frame.width/2
        let y = scrollView.contentOffset.y

        scrollView.setContentOffset(CGPoint(x: x, y: y), animated: true)
        confirmationPinView.beginUserInput()
    }
}

extension PinRegistrationViewController: PinInputViewDelegate {
    func didFinishInput(_ inputView: PinInputView, pin: String) {
        if inputView == pinView {
            scrollToConfirmation()
            model.storePin(pin)

        } else {
            model.checkPin(pin)
        }
    }
}
