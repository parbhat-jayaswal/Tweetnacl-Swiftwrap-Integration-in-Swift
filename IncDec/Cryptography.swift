//
//  IncDecMethod.swift
//  IncDec
//
//  Created by Parbhat on 23/01/23.
//


import Foundation
import TweetNacl


var skey = "*********************" // This will be your secretKey

func encryptOauth(message: String) -> String {
    print("secret_key \(skey)")
    let secretKey = Data(base64Encoded: skey)
    
    do {
        let keypair = try NaclBox.keyPair(fromSecretKey: secretKey!)
        let publicKey = keypair.publicKey
        let public_key =  publicKey.base64EncodedString()
        
        print("public_key \(public_key)")

        let msg = message.data(using: .utf8)
        let nonce = try NaclUtil.secureRandomData(count: 24)
        
        let nonce_key = nonce.base64EncodedString()
        
        print("Nonce key \(nonce_key)")
        
        let encriptedInfo = try NaclBox.box(message: msg!, nonce: nonce, publicKey: publicKey, secretKey: secretKey!)
        let encripted_info = encriptedInfo.base64EncodedString()
        
        print("Encripted Data \(encripted_info)")
        
        let jwe_token = "\(encripted_info)(=)\(nonce_key)(=)\(public_key)"
        
        return jwe_token
    }
    catch {
        print(error.localizedDescription)
        return "ERROR"
    }
    
}

func decryptOauth(encripted_info: String) -> String {
    let arrayInfo = encripted_info.components(separatedBy: "(=)")
    
    let publicKey = Data(base64Encoded: arrayInfo[2])
    let secretKey = Data(base64Encoded: skey)
    let nonceKey = Data(base64Encoded: arrayInfo[1])
    let msg = Data(base64Encoded: arrayInfo[0])
    
    do {
        let decryptInfo = try NaclBox.open(message: msg!, nonce: nonceKey!, publicKey: publicKey!, secretKey: secretKey!)
        let decrypt_info = String(decoding: decryptInfo, as: UTF8.self)
        
        return decrypt_info
    } catch {
        print(error.localizedDescription)
        return "ERROR"
    }
    
}

