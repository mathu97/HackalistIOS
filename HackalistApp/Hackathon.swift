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
    _notes,
    _year : String!
    
    private var _length,
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
    
    var year : String {
        if _year == nil{
            _year = ""
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
        if let title = json["title"]{
            self._title = title
        }
        
        if let webURL = json["url"] {
            self._webURL = webURL
        }

        if let location = json["city"] {
            self._location = location
        }
        
        if let host = json["host"] {
            self._host = host
        }
        
        if let startDate = json["startDate"] {
            self._startDate = startDate
        }
        
        if let endDate = json["endDate"] {
            self._endDate = endDate
        }
        
        if let fbURL = json["facebookURL"] {
            self._fbURL = fbURL
        }
        
        if let twitterURL = json["twitterURL"] {
            self._twitterURL = twitterURL
        }

        if let googlePlusURL = json["googlePlusURL"] {
            self._googlePlusURL = googlePlusURL
        }
        
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
        
        if let year = json["year"] {
            self._year = year
        }
        
        if let length = json["length"] {
            if Int(length) != nil{
                self._length = Int(length)
            } else {
                self._length = 0
            }
            
        }
        
        if let size = json["size"] {
            if Int(size) != nil {
                self._size = Int(size)
            } else {
                self._size = 0
            }
            
        }
        
        if let cost = json["cost"] {
            if cost == "free" {
                self._cost = "Free"
            } else {
                self._cost = cost
            }
        }
        
        
        
    }
    
    func lessThan (rhs: Hackathon) -> Bool{
        
        //Returns if current hackathon starts before the given hackathon
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM"
        
        let lhsMonthDateArray = self.startDate.components(separatedBy: " ")
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
        if lhsMonthDateArray[1].characters.count < 2 {
            lhsDayFiller = "0"
        }
        
        var rhsDayFiller = ""
        if rhsMonthDateArray[1].characters.count < 2 {
            rhsDayFiller = "0"
        }

        let lhsDate = myFormatter.date(from: "\(self.year)-\(lhsMonthfiller)\(lhsMonth)-\(lhsDayFiller)\(lhsMonthDateArray[1])")!
        let rhsDate = myFormatter.date(from: "\(rhs.year)-\(rhsMonthfiller)\(rhsMonth)-\(rhsDayFiller)\(rhsMonthDateArray[1])")!
        
        return lhsDate < rhsDate
    }

}


