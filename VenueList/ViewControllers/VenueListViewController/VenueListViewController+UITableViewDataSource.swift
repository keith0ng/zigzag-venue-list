//
//  VenueListViewController+UITableViewDataSource.swift
//  VenueList
//
//  Created by Keith Mark Samson on 22/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import Foundation
import UIKit

extension VenueListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return venueArray!.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

