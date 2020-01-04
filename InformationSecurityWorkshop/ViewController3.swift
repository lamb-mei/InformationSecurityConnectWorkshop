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



class ViewController3: UIViewController {
    
    
    @IBOutlet weak var inputkey: UITextField!
    @IBOutlet weak var inputIv: UITextField!
    @IBOutlet weak var orgiTextView: UITextView!
    @IBOutlet weak var crypTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        inputkey.text = "keykeykeykeykeyk"
        inputIv.text = "drowssapdrowssap"
        orgiTextView.text = """
        {
        "k1": "b637b17af08aced8850c18cccde915da",
        "k2": "61620957a1443c946a143cf99a7d24fa",
        "k3": "f7ab469d1dc79166fc874dadcc0dd854",
        }
        """
    }
    
    @IBAction func clickSendHandle(_ sender: Any) {
        if
            let aes = try? AES(key: inputkey.text!, iv: inputIv.text!) , // aes128
            let encrypted = try? aes.encrypt(orgiTextView.text!.bytes) ,
            let EncData = encrypted.toBase64()
        {
            crypTextView.text = EncData
        }
        
    }
    
    
}

