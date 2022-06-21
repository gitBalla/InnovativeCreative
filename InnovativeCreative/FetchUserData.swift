//
//  FetchUserData.swift
//  InnovativeCreative
//
//  Created by Vincent Tran on 21/6/2022.
//

import Foundation

class FetchUserData: ObservableObject {
    @Published var user = User()
    @Published var fetching = false
    
    @MainActor // Run on main thread
    func fetchData() async {
        fetching = true
        
        // Uncomment line below, run once, and comment again to load sample data.
        //saveSampleData()
        
        // Fetch data from UserDefaults
        let defaults = UserDefaults.standard
        if let savedUser = defaults.object(forKey: "savedUser") as? Data {
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(User.self, from: savedUser) {
                user = loadedUser
            }
        }
        fetching = false
    }
    
    func saveSampleData() {
        var tempUser = User()
        tempUser.streak = 3
        tempUser.itemsUnlocked.append(Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic))
        tempUser.dailyData.append(DailyData(date: "19/06/22", totalPoints: 10, itemsRecycled: ["9:00": Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic), "13:00": Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic)]))
        tempUser.dailyData.append(DailyData(date: "20/06/22", totalPoints: 5, itemsRecycled: ["7:00": Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic)]))
        tempUser.dailyData.append(DailyData(date: "21/06/22", totalPoints: 10, itemsRecycled: ["12:00": Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic), "15:00": Recyclable(name: "Plastic Bottle", pointValue: 5, material: .plastic)]))
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(tempUser) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "savedUser")
        }
    }
}
