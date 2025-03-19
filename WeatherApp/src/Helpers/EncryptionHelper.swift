//
//  EncryptionHelper.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import Foundation
import CryptoKit

struct EncryptionHelper {
    
    func getApiKey() -> String {
//        let key = SymmetricKey(size: .bits256)
//        let enc = encrypt(value: "123456", key: key)
//        let dec = decryptData(ciphertext: enc!, key: key)
//        let value = String(data: dec, encoding: .ascii)
//        return value!
        
        let password = "123456"
        
        guard let pvtKeyFile = Bundle.main.path(forResource: "pvtKey", ofType: "pem"),
                let apiKeyFile = Bundle.main.path(forResource: "enc_apikey", ofType: "txt") else {
            print("File not found")
            return ""
        }
        
        do {
            let pvtKey = try String(contentsOfFile: pvtKeyFile)
            let apiKey = try String(contentsOfFile: apiKeyFile)
            
            let data = NSData(base64Encoded: pvtKey, options:NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
            let attributes = [
                kSecAttrKeyType: kSecAttrKeyTypeRSA,
                kSecAttrKeyClass: kSecAttrKeyClassPublic
            ] as CFDictionary
            let error = UnsafeMutablePointer<Unmanaged<CFError>?>.allocate(capacity: 1)
            
            var pvtSecKey = SecKeyCreateWithData(data, attributes, error)
            print(error.pointee.debugDescription)

            let passwordData = password.data(using: .utf8)! as CFData

        } catch {
            print("Exception in getting contents.")
            return ""
        }
        return ""
    }
    
//    private func encrypt(value: String, key: SymmetricKey) -> String? {
//        let data = value.data(using: .utf8)
//        do {
//            let sealedBox = try AES.GCM.seal(data!, using: key)
//            let cText = String(data: sealedBox.ciphertext, encoding: .ascii)
//            return cText
//        } catch {
//            return nil
//        }
//    }
//    
//    private func decryptData(ciphertext: String?, key: SymmetricKey) -> Data {
//        let data = ciphertext?.data(using: .ascii)
//        do {
//            let sealedBox = try AES.GCM.SealedBox(combined: data!)
//            return try AES.GCM.open(sealedBox, using: key)
//        } catch {
//            return Data()
//        }
//    }
}
