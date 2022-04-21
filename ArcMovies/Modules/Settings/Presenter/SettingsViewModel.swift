//
//  SettingsViewModel.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {
    var router: SettingsRouter?

    @Published var guardEnabled = false {
        didSet {
            UserDefaults.standard.set(guardEnabled, forKey: UserDefaults.authenticationEnabledKey)
        }
    }

    @Published var biometricsEnabled = false {
        didSet {
            UserDefaults.standard.set(biometricsEnabled, forKey: UserDefaults.biometricEnabledKey)
        }
    }

    init() {
        guardEnabled = UserDefaults.authenticationEnabled
        biometricsEnabled = UserDefaults.biometricsEnabled
    }

    @MainActor
    func changeBiometricStatus() {
        if !biometricsEnabled {
            Task {
                biometricsEnabled = await AuthenticationService.shared.biometricAuthentication()
            }
        } else {
            biometricsEnabled.toggle()
        }
    }

    func registerNewPin() {
        router?.registerNewPin()
    }
}
