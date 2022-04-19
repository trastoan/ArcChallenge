//
//  PinInputView.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import UIKit

class PinInputView: UIView {
    let pinViews = [UIView(), UIView(), UIView(), UIView()]

    lazy var stack: UIStackView = {
        let stckView = UIStackView(arrangedSubviews: pinViews)
        stckView.translatesAutoresizingMaskIntoConstraints = false
        stckView.alignment = .center
        stckView.axis = .horizontal
        stckView.distribution = .equalSpacing
        stckView.spacing = 10
        return stckView
    }()

    let hiddenTextfield: UITextField = {
        let tf = UITextField()
        tf.keyboardType = .numberPad
        tf.isHidden = true
        return tf
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        hiddenTextfield.becomeFirstResponder()
        hiddenTextfield.delegate = self
        hiddenTextfield.addTarget(self, action: #selector(changedText), for: .editingChanged)
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
        self.addSubview(stack)

        pinViews.forEach { pinView in
            NSLayoutConstraint.activate([
                pinView.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
                pinView.widthAnchor.constraint(equalTo: pinView.heightAnchor)
            ])
        }

        stack.centerOnSelf(view: self)
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

extension PinInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textCount = textField.text?.count ?? 0
        if textCount >= 4 {
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
