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



class ViewController4: UIViewController {
    
    
    @IBOutlet weak var inputPubkey: UITextField!
    @IBOutlet weak var inputPrivkey: UITextField!
    @IBOutlet weak var orgiTextView: UITextView!
    @IBOutlet weak var crypTextView: UITextView!
    
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
        
        //這裡簡化流程，正常情況下要拿對方公鑰加密，傳輸出去對方才能用私鑰解開
        let defaultEncPublicKey = try! PublicKey(base64Encoded: inputPubkey.text!)
        let clear = try! ClearMessage(string: orgiTextView.text!, using: .utf8)
        let encrypted = try! clear.encrypted(with: defaultEncPublicKey, padding: .PKCS1)
        let EncData = encrypted.base64String
        
        crypTextView.text = EncData
        
    }
    
    
}

