//
//  ViewController.swift
//  proxytest
//
//  Created by 羊小咩 on 2019/3/21.
//  Copyright © 2019 Lambmei. All rights reserved.
//

import UIKit
import Alamofire
import PromiseKit

class ViewController1: UIViewController {
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
        Alamofire
            .request("https://httpbin.org/post", method: .post, parameters: dict)
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
    
}

