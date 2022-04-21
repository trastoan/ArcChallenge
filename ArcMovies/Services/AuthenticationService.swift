//
//  AuthenticationService.swift
//  ArcMovies
//
//  Created by Yuri on 19/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import LocalAuthentication

class AuthenticationService {
    static var shared = AuthenticationService()
    private init() {}

    func biometricAuthentication() async -> Bool {
        await withCheckedContinuation({ continuation in
            biometricAuth { success in
                continuation.resume(returning: success)
            }
        })
    }

    func savePin(_ value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        return KeychainManager.shared.save(data, service: KeychainManager.pinService)
    }

    func pinAuthentication(_ pin: String) -> Bool {
        guard let data = KeychainManager.shared.read(service: KeychainManager.pinService),
              let storedPin = String(data: data, encoding: .utf8) else {
            return false
        }

        return pin == storedPin
    }

    private func biometricAuth(completion: @escaping (Bool) -> ()) {
        let authContext = LAContext()
        var policyError: NSError?

        authContext.localizedCancelTitle = "Enter Pin"
        let reason = "Unlock your app"

        if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &policyError) {
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { success, error in
                    completion(success)
            })
        }
    }
}
