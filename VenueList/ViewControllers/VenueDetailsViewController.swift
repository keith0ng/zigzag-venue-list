//
//  VenueDetailsViewController.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit

class VenueDetailsViewController: UIViewController {
  
  var mainView: VenueDetailsView?
  var venue: Venue?
  
  override func loadView() {
    mainView = VenueDetailsView()
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    populateDetails()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func populateDetails() {
    mainView?.venueNameLabel.text = venue?.name
    let address = venue?.location?.formattedAddress?.joined(separator: ",")
    mainView?.venueAddressLabel.text = address
  }
}
