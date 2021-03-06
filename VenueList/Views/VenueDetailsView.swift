//
//  VenueDetailsView.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit

class VenueDetailsView: UIView {
  
  @IBOutlet weak var venueNameLabel: UILabel!
  @IBOutlet weak var venueAddressLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }
  
  func setupView() {
    let viewFromNib = viewFromOwnedNib()
    addSubviewAndFill(viewFromNib)
  }
  
  func setupLabels(withVenue venue: Venue?) {
    venueNameLabel.text = venue?.name
    
    let address = venue?.location?.formattedAddress?.joined(separator: ", ")
    venueAddressLabel.text = address
  }
}
