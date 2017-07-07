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
    var months = [String]() //Array of all months
    
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
        
        self.months = myFormatter.monthSymbols  //Array of all months
        
        let currentMonthIndex = self.months.index(of: curr_month)

        
        let year = calendar.component(.year, from: date)
        var month = ""
        var monthURL = ""
        var hkURL : URL
        
        //Getting the hackathons for the current month + year
        for i in currentDateComp.month! ... 12{
            
            if i <= 9{
                month = "0" + String(describing: i)
            }else{
                month = String(describing: i)
            }
        
            monthURL = API_URL + "/" + String(year) + "/" + month + ".json"
            hkURL = URL(string: monthURL)!
            apiRequest(hkURL: hkURL, currentMonthIndex: i-1){}
        }
    }
    
    func apiRequest(hkURL : URL, currentMonthIndex : Int, completed: @escaping DownloadComplete){
        //Gets hackathosn for the current month and adds the hackathon objects to the hackathons array
        print(hkURL)
        Alamofire.request(hkURL).responseJSON{ response in
            switch response.result {
            case .success:
                print(hkURL)
                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    
                        //print("month index: \(month_index)")
                        let month = self.months[currentMonthIndex]
                        //print("month: \(month)")
                        //print(hkURL)
                        print("JSON SFSAFD: \(json)")
                        let month_hackathons = json[month] as! [Dictionary<String, AnyObject>]
                        for case let result in month_hackathons{
                            let info = result as? [String: String]
                            self.hackathon = Hackathon(json: info!)
                            self.hackathons.append(self.hackathon)
                            
                            //print(self.hackathon.title)
                        }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

