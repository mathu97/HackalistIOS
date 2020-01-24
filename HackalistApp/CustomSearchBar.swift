//
//  CustomSearchBar.swift
//  HackalistApp
//
//  Created by Mathusan Selvarajah on 24/1/20.
//  Copyright © 2020 Mathusan. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar, UISearchBarDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
	override init(frame: CGRect) {
		super.init(frame: frame)
		self.returnKeyType = UIReturnKeyType.done
		self.layer.borderWidth = 10
		self.layer.borderColor = UIColor.white.cgColor
		self.placeholder = "Search Hackathons"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}
