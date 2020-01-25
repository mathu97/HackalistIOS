//
//  utils.swift
//  HackalistApp
//
//  Created by Mathusan Selvarajah on 23/1/20.
//  Copyright © 2020 Mathusan. All rights reserved.
//

import Foundation

func getAPIEndpoint(apiURLPrefix: String, month: Int) -> String{
	let currentYear = Calendar.current.component(.year, from: Date())
	let queryingMonth = month < 10 ? "0\(month)" : "\(month)"
	
	return "\(apiURLPrefix)/\(currentYear)/\(queryingMonth).json"
}

func getCurrentMonthNumber() -> Int {
	return Calendar.current.component(.month, from: Date())
}

func getMonthName(monthNum: Int) -> String {
	return DateFormatter().monthSymbols[monthNum - 1]
}

func sortHackathonByDate(hackathon1: Hackathon, hackathon2: Hackathon) -> Bool{
	return hackathon1.getStartDate() < hackathon2.getStartDate()
}
