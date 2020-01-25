//
//  HackathonDetailVC.swift
//  HackalistApp
//
//  Created by CLQA on 2017-08-17.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit
import MapKit

class HackathonDetailVC: UIViewController {
    var hackathon: Hackathon!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var capacityLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var travelReimbursementImg: UIImageView!
    @IBOutlet weak var prizesImg: UIImageView!
    @IBOutlet weak var highSchoolImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        setHackathonAddress()

    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setInfo() {
        var date: String
        date = "\(hackathon.startDate) - \(hackathon.endDate)"
        dateLbl.text = date
        locationLbl.text = hackathon.location
        capacityLbl.text = "\(hackathon.size) people"
        costLbl.text = hackathon.cost
        
        if hackathon.travel {
            //If there is travel reimbursement is provided
            travelReimbursementImg.image = UIImage(named: "checkIcon")
        } else {
            travelReimbursementImg.image = UIImage(named: "closeIcon")
        }
        
        if hackathon.prize {
            //If there are prizes in the hackathon
            prizesImg.image = UIImage(named: "checkIcon")
        } else {
            prizesImg.image = UIImage(named: "closeIcon")
        }
        
        if hackathon.highSchoolers {
            //If there are prizes in the hackathon
            highSchoolImg.image = UIImage(named: "checkIcon")
        } else {
            highSchoolImg.image = UIImage(named: "closeIcon")
        }
    }
    
    @IBAction func BackBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WebView" || segue.identifier == "twitterView" || segue.identifier == "facebookView"{
            if let webVC = segue.destination as? WebViewVC {
                if let hacks = sender as? Hackathon {
                    webVC.hackathon = hacks
                    if segue.identifier == "WebView" {
                        webVC.linkType = "WEB"
                    } else if segue.identifier == "twitterView" {
                        webVC.linkType = "TWITTER"
                    } else {
                        webVC.linkType = "FACEBOOK"
                    }
                }
            }
        }
    }
    
    @IBAction func webPageBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "WebView", sender: hackathon)
    }
    
    @IBAction func twitterBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "twitterView", sender: hackathon)
    }
    
    @IBAction func fbBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "facebookView", sender: hackathon)
    }
    
    
    func setHackathonAddress() {
        let address = hackathon.location
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            // Process Response
            if let placemark = placemarks?[0] {
                //Adding the annotation
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
                
                //Zooming into added annotation
                self.mapView.showAnnotations(self.mapView.annotations, animated: true)
            }
        }

    }
    

}
