//
//  VenueDetailsView.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit

class VenueDetailsView: UIView {
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
}
