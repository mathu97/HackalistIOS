//
//  ViewController.swift
//  HackalistApp
//
//  Created by CLQA on 2017-06-08.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hk = Hackathon(API_URL: "https://Hackalist.github.io/api/1.0/2017/01.json", hack_Title: "test")
    }



}

