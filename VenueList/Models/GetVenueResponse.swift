//
//  VenueResponse.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import Foundation

struct GetVenueResponse: Codable {
  
  var response: Response?
  
  struct Response: Codable {
    var venues: [Venue]
  }
}
