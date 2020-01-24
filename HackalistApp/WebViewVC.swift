//
//  WebViewVC.swift
//  HackalistApp
//
//  Created by Mathusan Selvarajah on 2017-08-18.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit
import Toast_Swift
import WebKit

class WebViewVC: UIViewController {
    var hackathon: Hackathon!
    var linkType : String!
    
	
	@IBOutlet weak var webView: WKWebView!
	@IBOutlet weak var progressBar: UIProgressView!
    
    var timeBool: Bool!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var urlString : String
        if linkType == "WEB" {
            urlString = hackathon.webURL
        } else if linkType == "TWITTER" {
            urlString = hackathon.twitterURL
        } else {
            urlString = hackathon.fbURL
        }
        if urlString == "" {
            webView.isHidden = true
            progressBar.isHidden = true
            self.view.makeToast("No \(linkType.lowercased()) page for this Hackathon", duration: 3.0, position: .bottom)
        } else {
            let url = URL(string: urlString)
			webView.load(URLRequest(url: url!))
			webView.allowsBackForwardNavigationGestures = true
        }

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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

    @objc func timerCallBack() {
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
                updatedProgress = progressBar.progress + 0.1
                progressBar.setProgress(updatedProgress, animated: true)
            }
            progressBar.isHidden = true
            timer.invalidate()
        }
        
    }
    
}
