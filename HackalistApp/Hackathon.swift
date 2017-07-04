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
    
    var title : String{
        if _title == nil{
            _title = ""
        }
        return _title
    }
    
    var webURL : String{
        if _webURL == nil{
            _webURL = ""
        }
        return _webURL
    }
    
    var location : String{
        if _location == nil{
            _location = ""
        }
        return _location
    }
    
    var host : String{
        if _host == nil{
            _host = ""
        }
        return _host
    }
    
    var startDate : String{
        if _startDate == nil{
            _startDate = ""
        }
        return _startDate
    }

    var endDate : String{
        if _endDate == nil{
            _endDate = ""
        }
        return _endDate
    }
    
    var fbURL : String{
        if _fbURL == nil{
            _fbURL = ""
        }
        return _fbURL
    }

    var twitterURL : String{
        if _twitterURL == nil{
            _twitterURL = ""
        }
        return _twitterURL
    }
    
    var googlePlusURL : String{
        if _googlePlusURL == nil{
            _googlePlusURL = ""
        }
        return _googlePlusURL
    }
    
    var cost : String{
        if _cost == nil{
            _cost = ""
        }
        return _cost
    }
    
    var notes : String{
        if _notes == nil{
            _notes = ""
        }
        return _notes
    }
    
    var year : Int {
        if _year == nil{
            _year = 0
        }
        
        return _year
    }

    var length : Int {
        if _length == nil{
            _length = 0
        }
        
        return _length
    }
    
    var size : Int {
        if _size == nil{
            _size = 0
        }
        
        return _size
    }
    
    var travel : Bool {
        return _travel
    }

    var highSchoolers : Bool{
        return _highSchoolers
    }
    
    var prize : Bool{
        return _prize
    }
    
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
        
        if (json["highSchoolers"] == "yes"){
            self._highSchoolers = true
        }else{
            self._highSchoolers = false
        }
        
        if (json["prize"] == "yes"){
            self._prize = true
        }else{
            self._prize = false
        }
        
        self._length = Int(json["length"]!)
        self._size = Int(json["size"]!)
    }
}
