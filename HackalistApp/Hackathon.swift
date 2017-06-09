//
//  Hackathon.swift
//  HackalistApp
//
//  Created by CLQA on 2017-06-08.
//  Copyright © 2017 Mathusan. All rights reserved.
//

import Foundation
import Alamofire

class Hackathon{
    private var _title,
                _webURL,
                _location,
                _host,
                _startDate,
                _endDate,
                _fbURL,
                _twitterURL,
                _googlePlusURL,
                _travel,
                _highSchoolers,
                _prize,
                _cost,
                _notes: String!

    private var _year,
                _length,
                _size: Int!
    
    init(API_URL: String, hack_Title: String){
        let hkURL = URL(string: API_URL)!
        
        Alamofire.request(hkURL).responseJSON{ response in
            switch response.result {
            case .success:
                print("Hello")
                let result = response.result
                print(result)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
