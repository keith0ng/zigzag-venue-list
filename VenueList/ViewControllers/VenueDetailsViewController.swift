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
  
    override func viewDidLoad() {
      super.viewDidLoad()
      mainView = VenueDetailsView()
      view = mainView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
