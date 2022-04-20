//
//  PinInputView.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

protocol PinInputViewDelegate: AnyObject {
    func didFinishInput(pin: String)
}

class PinInputView: UIView {
    private var pinViews: [UIView] = []

    lazy private var pinStack: UIStackView = {
        let stckView = UIStackView()
        stckView.translatesAutoresizingMaskIntoConstraints = false
        stckView.alignment = .center
        stckView.axis = .horizontal
        stckView.distribution = .fillEqually
        stckView.spacing = 20
        return stckView
    }()

    lazy private var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [messageLabel, pinStack])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 15
        return stack
    }()

    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.textColor = .systemBackground
        return label
    }()

    private let hiddenTextfield: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.isHidden = true
        return tf
    }()

    weak var delegate: PinInputViewDelegate?

    init(with message: String, pinSize: Int) {
        super.init(frame: .zero)

        messageLabel.text = message
        initPins(number: pinSize)
        setupConstraints()

        hiddenTextfield.addTarget(self, action: #selector(changedText), for: .editingChanged)
    }

    func beginUserInput() {
        hiddenTextfield.becomeFirstResponder()
    }

    private func initPins(number: Int) {
        for _ in 0..<number {
            let pin = UIView()
            pinStack.addArrangedSubview(pin)

            NSLayoutConstraint.activate([
                pin.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
                pin.widthAnchor.constraint(lessThanOrEqualToConstant: 20),
                pin.heightAnchor.constraint(equalTo: pin.widthAnchor)
            ])

            pinViews.append(pin)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        customizePinViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.addSubview(hiddenTextfield)
        self.addSubview(contentStack)

        let stackWidth = pinStack.widthAnchor.constraint(equalTo: contentStack.widthAnchor)
        stackWidth.priority = .defaultLow

        NSLayoutConstraint.activate([
            pinStack.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            stackWidth
        ])

        contentStack.centerOnSelf(view: self)
    }

    @objc
    private func changedText(textfield: UITextField) {
        let count = textfield.text?.count ?? 0
        for (index, pinView) in pinViews.enumerated() {
            if index < count {
                pinView.backgroundColor = .white
            } else {
                pinView.backgroundColor = .clear
            }
        }
        if count == pinViews.count {
            textfield.resignFirstResponder()
            delegate?.didFinishInput(pin: textfield.text!)
        }
    }

    private func customizePinViews() {
        pinViews.forEach { pin in
            pin.layer.cornerRadius = pin.frame.height/2
            pin.backgroundColor = .clear
            pin.layer.borderWidth = 1
            pin.layer.borderColor = UIColor.white.cgColor
        }
    }
}
