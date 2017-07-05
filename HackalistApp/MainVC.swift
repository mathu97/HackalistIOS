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
    var hackathon : Hackathon!
    var hackathons = [Hackathon]() //Array of all hackathons
    
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
        
        myFormatter.dateFormat = "MMMM"
        let curr_month_data = calendar.date(from: currentDateComp)!
        let curr_month = myFormatter.string(from: curr_month_data)
        
        let months = myFormatter.monthSymbols  //Array of all months
        
        let currentMonthIndex = months?.index(of: curr_month)
        //print(months)
        //print(currentMonthIndex)
        
        //print("current DAte: \(curr_date), current Month: \(curr_month)")
        
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
                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    for month_index in Int(currentMonthIndex!) ..< 12{
                        let month = months?[month_index]
                        print(month)
                        let month_hackathons = json[month!] as! [Dictionary<String, AnyObject>]
                        for case let result in month_hackathons{
                            let info = result as? [String: String]
                            self.hackathon = Hackathon(json: info!)
                            self.hackathons.append(self.hackathon)
                            
                            print(self.hackathon.title)
                        }
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

