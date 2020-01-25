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
    
    var hackathons = [Hackathon]() //Array of all hackathons
    var filteredHackathons = [Hackathon]()
    var doneDownload = false

    let group = DispatchGroup()

  
	@IBOutlet weak var TableView: UITableView!
	@IBOutlet weak var segmentedControl: UISegmentedControl!
	
	let searchBar = CustomSearchBar()
    var currentlySearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

		TableView.delegate = self
        TableView.dataSource = self
        getHackathonData(API_URL: "https://Hackalist.github.io/api/1.0")
        
		searchBar.delegate = self
		
		self.navigationItem.titleView = searchBar
        group.notify(queue: .main) {
            self.doneDownload = true
			self.hackathons = self.hackathons.sorted(by: sortHackathonByDate)
			self.TableView.reloadData()
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
        if currentlySearching {
            return filteredHackathons.count
        }
 
        return hackathons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = TableView.dequeueReusableCell(withIdentifier: "hackathonCell", for: indexPath) as? HackathonCell {
            var newHackathon: Hackathon!
            
            if currentlySearching {
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

    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            if doneDownload {
				self.hackathons = self.hackathons.sorted(by: sortHackathonByDate)
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
    
    func lessThanByTitle(lhs: Hackathon, rhs: Hackathon) -> Bool{
        //Returns true if lhs hackathon title comes before rhs hackathon title, else it returns false
        
        if lhs.title.lowercased() < rhs.title.lowercased() {
            return true
        }
        
        return false
    }
    
}

extension MainVC : UISearchBarDelegate {
	
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		//If the scrollview is dragged
		searchBar.endEditing(true)
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //This will be called, everytime we make a keystroke in the searchbar
        
        if searchBar.text == nil ||  searchBar.text == "" {
            
            currentlySearching = false
            self.TableView.reloadData()
            
            view.endEditing(true) //Hide the keyboard
            
        } else {
            currentlySearching = true
            let searchBarText = searchBar.text!.lowercased()
            
            filteredHackathons = hackathons.filter({$0.title.lowercased().range(of: searchBarText) != nil})
            self.TableView.reloadData()
        }
        
    }
}

