//
//  HackathonDetailVC.swift
//  HackalistApp
//
//  Created by CLQA on 2017-08-17.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit

class HackathonDetailVC: UIViewController {
    var hackathon: Hackathon!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = hackathon.title

        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebViewVC" {
            if let webVC = segue.destination as? WebViewVC {
                if let hacks = sender as? Hackathon {
                    webVC.hackathon = hacks
                }
            }
        }
    }
    
    @IBAction func webPageBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "WebViewVC", sender: hackathon)
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
