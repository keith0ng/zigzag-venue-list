//
//  VenueListViewController+UITableViewDelegate.swift
//  VenueList
//
//  Created by Keith Mark Samson on 22/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import Foundation
import UIKit

extension VenueListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellReuseIdentifier")
    let row = indexPath.row
    let venue = venueArray![row]
    cell.textLabel?.text = venue.name!
    cell.detailTextLabel?.text = "\(venue.location!.distance!)m"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let venueDetailsVC = VenueDetailsViewController()
    venueDetailsVC.venue = venueArray![indexPath.row]
    navigationController?.pushViewController(venueDetailsVC, animated: true)
  }
}
