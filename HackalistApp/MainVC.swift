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
        let hkData = getData(API_URL: "https://Hackalist.github.io/api/1.0/2017/01.json")
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
        
        
        let hkURL = URL(string: API_URL)!
        
        Alamofire.request(hkURL).responseJSON{ response in
            switch response.result {
            case .success:
                if let json = response.result.value {
                    print("JSON: \(json)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

