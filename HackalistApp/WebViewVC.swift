//
//  WebViewVC.swift
//  HackalistApp
//
//  Created by Mathusan Selvarajah on 2017-08-18.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController {
    var hackathon: Hackathon!
    
    @IBOutlet weak var mainWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: hackathon.webURL)
        let requestObj = URLRequest(url: url!)
        
        mainWebView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }

    @IBAction func DoneBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
