//
//  KeychainManager.swift
//  ArcMovies
//
//  Created by Yuri on 21/04/22.
//  Copyright © 2022 YuriFrota. All rights reserved.
//

import Foundation

class KeychainManager {
    static var shared = KeychainManager()

    static let pinService = "SecurityPin"
    static let account =  "ArcMovies"

    private init() {}

    func save(_ data: Data, service: String, account: String = KeychainManager.account) -> Bool {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status != errSecSuccess {
            print("Error: \(status)")
            if status == errSecDuplicateItem {
                return update(data: data, service: service, account: account)
            }
            return false
        }

        return true
    }

    func update(data: Data, service: String, account: String = KeychainManager.account) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let attrToUpdate = [kSecValueData: data] as CFDictionary
        let status = SecItemUpdate(query, attrToUpdate)
        if status != errSecSuccess {
            print("Error: \(status)")
            return false
        }
        return true
    }

    func read(service: String, account: String = KeychainManager.account) -> Data? {
        let query = [
               kSecAttrService: service,
               kSecAttrAccount: account,
               kSecClass: kSecClassGenericPassword,
               kSecReturnData: true
           ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        return result as? Data
    }

}
