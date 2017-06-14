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
    _cost,
    _notes: String!
    
    private var _year,
    _length,
    _size: Int!
    
    private var _travel, _highSchoolers, _prize : Bool
    
    init(json : [String: String]){
        self._title = json["title"]
        self._webURL = json["url"]
        self._location = json["city"]
        self._host = json["host"]
        self._startDate = json["startDate"]
        self._endDate = json["endDate"]
        self._fbURL = json["facebookURL"]
        self._twitterURL = json["twitterURL"]
        self._googlePlusURL = json["googlePlusURL"]
        
        if (json["travel"] == "yes"){
            self._travel = true
        }else{
            self._travel = false
        }
        
    }
}
