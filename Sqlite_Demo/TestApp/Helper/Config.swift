//
//  TestApp
//
//  Created by ashwani yadav on 24/05/20.
//  Copyright © 2020 ashwani yadav. All rights reserved.
//

import Foundation
import UIKit

struct Config{
  static let clientId = "2UQLNATHEVWFYMFETNUOLRZRFNWY141S14UDYXJQF0TWMW2S"
   static let clientSecret = "XN0XNAOWBO5OBJI2PS5DE1S2I2JIJHZAMRWTE5X0BNBN13SI"
   static let date = "20200608"
   static let baseURL = "https://api.foursquare.com/v2/venues/search?ll=40.7484,-73.9857&client_id=\(clientId)&client_secret=\(clientSecret)&v=\(date)"
}


struct Color {
    static let primaryColor = UIColor(red: 0.22, green: 0.58, blue: 0.29, alpha: 1.0)
    static let secondaryColor = UIColor.lightGray
}


// MARK: Sqlite Database Handler

import SQLite
class DatabaseHandler {
    static let path = NSSearchPathForDirectoriesInDomains(
        .documentDirectory, .userDomainMask, true
    ).first!
    
    func createTableVenue() {
        let db = try! Connection("\(DatabaseHandler.path)/db.sqlite3")

        let venues = Table("Venue")
            let id = Expression<String>("id")
              let name = Expression<String?>("name")
              try! db.run(venues.create(ifNotExists: true) { aTable in
                  aTable.column(id, primaryKey: true)
                  aTable.column(name)
              })
          
    }
    
    func saveVenue(venue: Venue) {
        let db = try! Connection("\(DatabaseHandler.path)/db.sqlite3")
        let venues = Table("Venue")
        let id = Expression<String>("id")
        let name = Expression<String?>("name")
        self.deleteVenue(venueId: venue.venueId)
        let insert = venues.insert(name <- "\(venue.name)", id <- "\(venue.venueId)")
        try! db.run(insert)
    }
    
    func fetchSavedVenues() -> [Venue]{
        let db = try! Connection("\(DatabaseHandler.path)/db.sqlite3")
        let venues = Table("Venue")
        var venueList = [Venue]()
        let id = Expression<String>("id")
        let name = Expression<String?>("name")
        for venue in try! db.prepare(venues) {
            print("id: \(venue[id]), name: \(String(describing: venue[name]))")
            let aVenue = Venue.init(name: venue[name]! , id: venue[id])
            venueList.append(aVenue)
        }
        
        return venueList
    }
    
    func deleteVenue(venueId: String) {
        let db = try! Connection("\(DatabaseHandler.path)/db.sqlite3")
       let venues = Table("Venue")
       let id = Expression<String>("id")
       let aVenue = venues.filter(id == venueId)
       try! db.run(aVenue.delete())
    }
}
