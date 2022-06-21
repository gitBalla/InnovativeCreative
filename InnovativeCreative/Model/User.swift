//
//  User.swift
//  InnovativeCreative
//
//  Created by Vincent Tran on 21/6/2022.
//

import Foundation

struct User: Codable {
    //var dailyPoints: [String: String] // Date: Pts
    var streak: Int = 0
    var itemsUnlocked: [Recyclable] = [] // Items user has scanned
    var dailyData: [DailyData] = []
}

struct DailyData: Codable {
    var date: String // Date only, no time/hour
    var totalPoints: Int = 0
    var itemsRecycled: [String: Recyclable] // Time: Item
}

struct Recyclable: Codable {
    var name: String
    var pointValue: Int
    var material: recycleMaterial
}

enum recycleMaterial: String, Codable {
    case plastic
    case glass
    case aluminium
}
