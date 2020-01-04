//
//  ViewController2.swift
//  InformationSecurityWorkshop
//
//  Created by 羊小咩 on 2020/1/4.
//  Copyright © 2020 羊小咩. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift
import SwiftyRSA




class ViewController5: UIViewController {
    
    
    @IBOutlet weak var inputPubkey: UITextField!
    @IBOutlet weak var inputPrivkey: UITextField!
    @IBOutlet weak var orgiTextView: UITextView!
    @IBOutlet weak var crypTextView: UITextView!
    @IBOutlet weak var crypKeyTextView: UITextView!
    @IBOutlet weak var crypSignatureTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let keyPair = try! SwiftyRSA.generate2048RSAKeyPairAdv()
        let privateKey = keyPair.privateKey
        let publicKey = keyPair.publicKey
        
        inputPubkey.text = try! publicKey.base64String()
        inputPrivkey.text = try! privateKey.base64String()
        orgiTextView.text = """
        {
        "k1": "b637b17af08aced8850c18cccde915da",
        "k2": "61620957a1443c946a143cf99a7d24fa",
        "k3": "f7ab469d1dc79166fc874dadcc0dd854",
        }
        """
    }
    
    @IBAction func clickSendHandle(_ sender: Any) {
        
        //金鑰加密
        let EncPublicKey = try! PublicKey(base64Encoded: inputPubkey.text!)
        let clear = try! ClearMessage(string: "aes128 keykeykeykeykeyk:ooooxxxxooooxxxx", using: .utf8)
        let encrypted = try! clear.encrypted(with: EncPublicKey, padding: .PKCS1)
        let EncAESData = encrypted.base64String
        crypKeyTextView.text = EncAESData
        print(EncAESData)
        
        //資料加密
        if
            let aes = try? AES(key: "keykeykeykeykeyk", iv: "ooooxxxxooooxxxx") , // aes128
            let encrypted = try? aes.encrypt(orgiTextView.text!.bytes) ,
            let EncData = encrypted.toBase64()
        {
            crypTextView.text = EncData
            print(EncData)
            
            //簽名   使用自己的私鑰簽名，對方使用你的公鑰驗證
            let privateKey = try! PrivateKey(base64Encoded: inputPrivkey.text!)
            let pClear = try! ClearMessage(string: EncData, using: .utf8)
            let pSignature = try! pClear.signed(with: privateKey, digestType: .sha256)
            crypSignatureTextView.text = pSignature.base64String
            print(pSignature)
        }
        
        
        
        
        
    }
    
    
}

