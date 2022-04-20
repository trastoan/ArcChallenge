//
//  UserDefaults+UserConfiguration.swift
//  ArcMovies
//
//  Created by Yuri on 20/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation
extension UserDefaults {
    static let authenticationEnabledKey = "authenticationEnabled"
    static let biometricEnabledKey = "biometricsEnabled"

    static var authenticationEnabled: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.authenticationEnabledKey)
    }

    static var biometricsEnabled: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaults.biometricEnabledKey)
    }
}
