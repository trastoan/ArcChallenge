//
//  PinRegistrationModel.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation

class PinRegistrationViewModel {
    var router: PinRegistrationRouter!
    var failedConfirmation: (()->())?

    private var registeredPin = ""

    func cancelRegistration() {
        router.dismissController()
    }

    func storePin(_ value: String) {
        registeredPin = value
    }

    func checkPin(_ value: String) {
        if registeredPin == value {
            _ = AuthenticationService.shared.savePin(value)
            router.dismissController()
        } else {
            failedConfirmation?()
        }
    }
}
