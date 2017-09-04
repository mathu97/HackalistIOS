//
//  ViewController.swift
//  HackalistApp
//
//  Created by CLQA on 2017-06-08.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    var hackathon : Hackathon?
    var hackathons = [Hackathon]() //Array of all hackathons
    var months = [String]() //Array of all months
    let group = DispatchGroup()
    var doneDownload = false

    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.delegate = self
        TableView.dataSource = self
        getData(API_URL: "https://Hackalist.github.io/api/1.0")

        group.notify(queue: .main) {
            self.doneDownload = true
            //*****Can use this block to execute any code after all hackathon requests have been made
        }
        
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
            group.enter()
            
            if i <= 9{
                month = "0" + String(describing: i)
            }else{
                month = String(describing: i)
            }
        
            monthURL = API_URL + "/" + String(year) + "/" + month + ".json"
            hkURL = URL(string: monthURL)!
            dataApiRequest(hkURL: hkURL, currentMonthIndex: i-1){}
        }

    }
    
    
    func dataApiRequest(hkURL : URL, currentMonthIndex : Int, completed: @escaping DownloadComplete){
        //Gets hackathosn for the current month and adds the hackathon objects to the hackathons array
        Alamofire.request(hkURL).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:

                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    
                        let month = self.months[currentMonthIndex]
                        let month_hackathons = json[month] as! [Dictionary<String, AnyObject>]
                        for case let result in month_hackathons{
                            let info = result as? [String: String]
                            self.hackathon = Hackathon(json: info!)
                            self.hackathons.append(self.hackathon!)
                            
                        }
                       self.TableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
            self.group.leave()
            
            completed()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HackathonDetailVC" {
            if let detailsVC = segue.destination as? HackathonDetailVC {
                if let hacks = sender as? Hackathon {
                    detailsVC.hackathon = hacks
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var hacks: Hackathon!
        hacks = hackathons[indexPath.row]
        performSegue(withIdentifier: "HackathonDetailVC", sender: hacks)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackathons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = TableView.dequeueReusableCell(withIdentifier: "hackathonCell", for: indexPath) as? HackathonCell {
            let newHackathon = hackathons[indexPath.row]
            cell.configureCell(hackathon: newHackathon)
            return cell
        }else{
            return HackathonCell() //Return an empty hackathon cell
        }
        
    }

    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            if doneDownload {
                self.hackathons.sort(by: self.lessThanByDate)
                self.TableView.reloadData()
            }
        case 1: //Not implemented yet
            if doneDownload {
                self.hackathons.sort(by: self.lessThanByTitle)
                self.TableView.reloadData()
            }
        default:
            break;
        }
    }
    
    func lessThanByDate (lhs: Hackathon, rhs: Hackathon) -> Bool{
        
        //Returns true if lhs hackathon starts before rhs hackathon, else it returns false
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM"
        
        let lhsMonthDateArray = lhs.startDate.components(separatedBy: " ")
        let rhsMonthDateArray = rhs.startDate.components(separatedBy: " ")
        
        let lhsMonthDate = myFormatter.date(from: lhsMonthDateArray[0])!
        let rhsMonthDate = myFormatter.date(from: rhsMonthDateArray[0])!
        
        let lhsMonth = Calendar.current.component(.month, from: lhsMonthDate)
        let rhsMonth = Calendar.current.component(.month, from: rhsMonthDate)
        
        myFormatter.dateFormat = "yyyy-MM-dd"
        
        var lhsMonthfiller = ""
        if lhsMonth < 10 {
            lhsMonthfiller = "0"
        }
        
        var rhsMonthfiller = ""
        if rhsMonth < 10 {
            rhsMonthfiller = "0"
        }
        
        var lhsDayFiller = ""
        if lhsMonthDateArray[1].characters.count < 2 {
            lhsDayFiller = "0"
        }
        
        var rhsDayFiller = ""
        if rhsMonthDateArray[1].characters.count < 2 {
            rhsDayFiller = "0"
        }
        
        let lhsDate = myFormatter.date(from: "\(lhs.year)-\(lhsMonthfiller)\(lhsMonth)-\(lhsDayFiller)\(lhsMonthDateArray[1])")!
        let rhsDate = myFormatter.date(from: "\(rhs.year)-\(rhsMonthfiller)\(rhsMonth)-\(rhsDayFiller)\(rhsMonthDateArray[1])")!
        
        return lhsDate < rhsDate
    }
    
    func lessThanByTitle(lhs: Hackathon, rhs: Hackathon) -> Bool{
        //Returns true if lhs hackathon title comes before rhs hackathon title, else it returns false
        
        if lhs.title.lowercased() < rhs.title.lowercased() {
            return true
        }
        
        return false
    }
    
}

