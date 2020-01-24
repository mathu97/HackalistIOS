//
//  ViewController.swift
//  HackalistApp
//
//  Created by CLQA on 2017-06-08.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit
import Alamofire

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    var hackathons = [Hackathon]() //Array of all hackathons
    var filteredHackathons = [Hackathon]()
    var doneDownload = false

    let group = DispatchGroup()

  
	@IBOutlet weak var TableView: UITableView!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
    var inSearchMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

		TableView.delegate = self
        TableView.dataSource = self
        getHackathonData(API_URL: "https://Hackalist.github.io/api/1.0")
        
//        searchBar.delegate = self
        let searchBar = CustomSearchBar()
		searchBar.delegate = self
		
		self.navigationItem.titleView = searchBar
        group.notify(queue: .main) {
            self.doneDownload = true
            //*****Can use this block to execute any code after all hackathon requests have been made
        }
        
    }
    
    func getHackathonData(API_URL : String){
        //Getting the hackathons for the current month + year
        for month in getCurrentMonthNumber() ... 12{
            group.enter()
            
			let apiEndPoint = getAPIEndpoint(apiURLPrefix: API_URL, month: month)
			dataApiRequest(hkURL: URL(string: apiEndPoint)!, currentMonthNum: month){}
        }

    }
    
    
    func dataApiRequest(hkURL : URL, currentMonthNum : Int, completed: @escaping DownloadComplete){
        //Gets hackathosn for the current month and adds the hackathon objects to the hackathons array
        Alamofire.request(hkURL).responseJSON(completionHandler: { response in
            switch response.result {
            case .success:

                if let json = response.result.value as? Dictionary<String, AnyObject> {
                    

					let month_hackathons = json[getMonthName(monthNum: currentMonthNum)] as! [Dictionary<String, AnyObject>]
                        for case let result in month_hackathons{
                            let info = result as? [String: String]
							let newHackathon = Hackathon(json: info!)
                            self.hackathons.append(newHackathon)
                            
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
					detailsVC.navigationItem.title = hacks.title
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
        if inSearchMode {
            return filteredHackathons.count
        }
 
        return hackathons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = TableView.dequeueReusableCell(withIdentifier: "hackathonCell", for: indexPath) as? HackathonCell {
            var newHackathon: Hackathon!
            
            if inSearchMode {
                newHackathon = filteredHackathons[indexPath.row]
            }
            else {
                newHackathon = hackathons[indexPath.row]
            }
            
            cell.configureCell(hackathon: newHackathon)
            return cell
        }else{
            return HackathonCell() //Return an empty hackathon cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 115
    
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        view.endEditing(true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //This will be called, everytime we make a keystroke in the searchbar
        
        if searchBar.text == nil ||  searchBar.text == "" {
            
            inSearchMode = false
            self.TableView.reloadData()
            
            view.endEditing(true) //Hide the keyboard
            
        } else {
            inSearchMode = true
            
            let lower = searchBar.text!.lowercased()
            
            filteredHackathons = hackathons.filter({$0.title.lowercased().range(of: lower) != nil})
            self.TableView.reloadData()
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
        if lhsMonthDateArray[1].count < 2 {
            lhsDayFiller = "0"
        }
        
        var rhsDayFiller = ""
        if rhsMonthDateArray[1].count < 2 {
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

