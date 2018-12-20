//
//  Venue.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import Foundation

struct Venue: Codable {
  var name: String? = ""
  var address: String? = ""
  var distance: Int? = 0
  
  init(dictionary: [String: Any]) {
    let location = dictionary["location"] as? [String: Any]
    
    name = dictionary["name"] as? String
    address = returnFormattedAddress(location!)
    distance = location!["distance"] as? Int
  }
  
  private func returnFormattedAddress(_ location: [String: Any]?) -> String {
    let baseAddress = location!["formattedAddress"] as? [String]
    return baseAddress!.joined(separator: ",")
  }
}
