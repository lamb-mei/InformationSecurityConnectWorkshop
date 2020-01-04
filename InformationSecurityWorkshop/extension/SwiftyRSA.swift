//
//  SwiftyRSA.swift
//  iCashPayFramework
//
//  Created by 羊小咩 on 2019/3/13.
//  Copyright © 2019 . All rights reserved.
//

import SwiftyRSA

extension SwiftyRSA
{
    static func generate2048RSAKeyPairAdv() throws -> (privateKey: PrivateKey, publicKey: PublicKey) {
        
        let size = 2048
        let uuidstr = UUID().uuidString
        guard let tagData = uuidstr.data(using: .utf8) else {
            throw SwiftyRSAError.stringToDataConversionFailed
        }
        
        let attributes: [CFString: Any] = [
            kSecAttrKeyType: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits: size,
            kSecPrivateKeyAttrs: [
                kSecAttrIsPermanent: false,
                kSecAttrApplicationTag: tagData
            ]
        ]
        
        var error: Unmanaged<CFError>?
        guard let privKey = SecKeyCreateRandomKey(attributes as CFDictionary, &error),
            let pubKey = SecKeyCopyPublicKey(privKey) else {
                throw SwiftyRSAError.keyGenerationFailed(error: error?.takeRetainedValue())
        }
        let privateKey = try PrivateKey(reference: privKey)
        let publicKey = try PublicKey(reference: pubKey)
        
        return (privateKey: privateKey, publicKey: publicKey)
    }
}

