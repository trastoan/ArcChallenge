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

    func askForAuthentication(completion: @escaping (Bool) -> ()) {
        let authContext = LAContext()
        var policyError: NSError?

        authContext.localizedCancelTitle = "Enter Pin"
        let reason = "Unlock your app"

        if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &policyError) {
            authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason, reply: { success, error in
                if success {
                    completion(true)
                } else {
                    completion(false)
                }

            })
        }
    }
}
