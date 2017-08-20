//
//  WebViewVC.swift
//  HackalistApp
//
//  Created by Mathusan Selvarajah on 2017-08-18.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit

class WebViewVC: UIViewController, UIWebViewDelegate {
    var hackathon: Hackathon!
    
    @IBOutlet weak var mainWebView: UIWebView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var timeBool: Bool!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainWebView.delegate = self
        
        let url = URL(string: hackathon.webURL)
        let requestObj = URLRequest(url: url!)

        mainWebView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }

    @IBAction func DoneBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        progressBar.progress = 0.0
        timeBool = true
        timer = Timer.scheduledTimer(timeInterval: 0.15, target: self, selector: #selector(timerCallBack), userInfo: nil, repeats: true)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        timeBool = false

    }

    func timerCallBack() {
        var updatedProgress: Float
        
        if timeBool == true {
            
            if progressBar.progress >=  0.95 {
                updatedProgress = 0.95
            } else {
                updatedProgress = progressBar.progress + 0.05
                progressBar.setProgress(updatedProgress, animated: true)
                
            }
        } else {
            while progressBar.progress < 1 {
                //Finish the loading animation
                print("enterswsss")
                updatedProgress = progressBar.progress + 0.1
                progressBar.setProgress(updatedProgress, animated: true)
            }
            progressBar.isHidden = true
            timer.invalidate()
        }
        
    }
}
