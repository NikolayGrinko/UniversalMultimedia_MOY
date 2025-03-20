//
//  KeychainService.swift
//  UniversalMultimediaApplication1
//
//  Created by Николай Гринько on 27.02.2025.
//

import Foundation
import Security

final class KeychainService {
    static func save(apiKey: String) {
        let key = "OpenAIKey"
        guard let data = apiKey.data(using: .utf8) else { return }

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]

        SecItemDelete(query as CFDictionary)
        SecItemAdd(query as CFDictionary, nil)
    }

    static func getAPIKey() -> String? {
        let key = "OpenAIKey"
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue!
        ]

        var dataTypeRef: AnyObject?
        if SecItemCopyMatching(query as CFDictionary, &dataTypeRef) == noErr,
           let data = dataTypeRef as? Data,
           let apiKey = String(data: data, encoding: .utf8) {
            return apiKey
        }
        return nil
    }
}
