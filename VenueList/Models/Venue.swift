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
  var location: Location?
  
  struct Location: Codable {
    var formattedAddress: [String?]
    var distance: Int?
  }
}



