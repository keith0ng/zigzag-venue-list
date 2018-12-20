//
//  UIView.swift
//  VenueList
//
//  Created by Keith Mark Samson on 20/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit

extension UIView {
  
  func viewFromOwnedNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first(where: { $0 is UIView }) as! UIView
  }
  
  func addSubviewAndFill(_ subview: UIView) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
    subview.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    subview.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
  }
  
  class func nib() -> UINib {
    return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
  
}
