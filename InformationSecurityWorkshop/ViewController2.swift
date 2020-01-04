//
//  ViewController2.swift
//  InformationSecurityWorkshop
//
//  Created by 羊小咩 on 2020/1/4.
//  Copyright © 2020 羊小咩. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit
import CryptoSwift



class ViewController2: UIViewController {
    @IBOutlet weak var inputkeyID: UITextField!
    @IBOutlet weak var input0: UITextField!
    @IBOutlet weak var input1: UITextField!
    @IBOutlet weak var input2: UITextField!
    @IBOutlet weak var repTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func clickSendHandle(_ sender: Any) {
        self.repTextView.text = ""
        let dict = ["p1" : input1.text!,
                    "p2" : input2.text!]
        
        
        let dateString = query(dict) //使用預設的 URLEncoding.default 產生Body Encode
        print(dateString)
        
        
        let keybytes: Array<UInt8> = input0.text!.bytes
        let signature = try! HMAC(key: keybytes, variant: .sha256).authenticate(dateString.bytes)
        print("signature \(signature.toHexString())")
        
        
        let headers: HTTPHeaders = [
            "x-keyid": inputkeyID.text!,
            "x-signature":signature.toHexString()
        ]
        
        
        Alamofire
            .request("http://isw.lamb-mei.com/api/verifyHMAC", method: .post, parameters: dict,headers: headers)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let rawData = String(data: data, encoding: .utf8)
                    self.repTextView.text = rawData
                    break
                case .failure(let error):
                    self.repTextView.text = error.localizedDescription
                    break
                }
        }
        
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += URLEncoding.default.queryComponents(fromKey: key, value: value)
        }
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }
    
}

