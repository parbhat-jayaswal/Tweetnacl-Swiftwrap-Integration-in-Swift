//
//  ViewController.swift
//  IncDec
//
//  Created by Parbhat on 23/01/23.
//

import UIKit

import TweetNacl

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let info = encryptOauth(message: "Hi")
        print(info)
        
        if info != "ERROR" {
            print(decryptOauth(encripted_info: info))
        }
    }


}

