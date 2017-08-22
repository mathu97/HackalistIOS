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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = hackathon.title
        setHackathonAddress()

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
