//
//  GuardViewModel.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation

class GuardViewModel {
    var router: GuardRouter!
    var defaultAuthentication: (() -> ())?
    var failedToAuthenticate: (()->())?

    @MainActor
    func authenticateUser() {
        if UserDefaults.biometricsEnabled {
            Task {
                if await AuthenticationService.shared.biometricAuthentication() {
                    router.dismissController()
                } else {
                    defaultAuthentication?()
                }
            }
        } else {
            defaultAuthentication?()
        }
    }

    func pinAuthentication(passcode: String) {
        if AuthenticationService.shared.pinAuthentication(passcode) {
            self.router.dismissController()
        } else {
            failedToAuthenticate?()
        }
    }
}
