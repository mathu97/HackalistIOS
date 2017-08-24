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
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var capacityLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var travelReimbursementImg: UIImageView!
    @IBOutlet weak var prizesImg: UIImageView!
    @IBOutlet weak var highSchoolImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = hackathon.title
        setHackathonAddress()

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
