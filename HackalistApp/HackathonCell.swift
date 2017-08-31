//
//  HackathonCell.swift
//  HackalistApp
//
//  Created by CLQA on 2017-06-08.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import UIKit

class HackathonCell: UITableViewCell {
    
    @IBOutlet weak var HkLabel: UILabel!
    @IBOutlet weak var letterLbl: UILabel!

    func configureCell(hackathon: Hackathon){
        HkLabel.text = hackathon.title
//        letterLbl.text = "\(hackathon.title.capitalized.characters.first!)"
//        
//        let red = CGFloat(drand48())
//        let green = CGFloat(drand48())
//        let blue = CGFloat(drand48())
//        
//        letterBackground.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.75)
//        print("enters colors")
    }

}
