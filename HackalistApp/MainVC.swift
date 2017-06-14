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
    
    var Hackathons: [Hackathon] = [] //Array of all hackathons
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hkData = getData(API_URL: "https://Hackalist.github.io/api/1.0")
    }
    
    func getData(API_URL : String){
        //Get current date and format it to look like the response startDate
        let date = Date()
        var currentDateComp = DateComponents()
        let calendar = Calendar.current
        
        currentDateComp.month = calendar.component(.month, from: date)
        currentDateComp.day = calendar.component(.day, from: date)
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MMMM d"
        let curr_date_data = calendar.date(from: currentDateComp)!
        let curr_date = myFormatter.string(from: curr_date_data)
        
        
        let year = calendar.component(.year, from: date)
        var month = ""
        
        //Getting the hackathons for the current month + year
        if currentDateComp.month! <= 9{
            month = month + "0" + String(describing: currentDateComp.month!)
        }else{
            month = month + String(describing: currentDateComp.month!)
        }
        
        let API_URL = API_URL + "/" + String(year) + "/" + month + ".json"
        
        let hkURL = URL(string: API_URL)!
        
        Alamofire.request(hkURL).responseJSON{ response in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    let month = json["June"]
                    for case let result in (month as? [Any])!{
                        let info = result as? [String: String]
                        var new_hackathon = Hackathon(json: info!)
                        self.Hackathons.append(new_hackathon)
                    }
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

