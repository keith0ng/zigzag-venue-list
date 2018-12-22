//
//  VenueListViewController+CLLocationManagerDelegate.swift
//  VenueList
//
//  Created by Keith Mark Samson on 22/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import Foundation
import CoreLocation

extension VenueListViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = manager.location
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    let locationAuthStatus = CLLocationManager.authorizationStatus()
    switch locationAuthStatus {
    case .authorizedWhenInUse, .authorizedAlways:
        currentLocation = manager.location
        
        let lat = currentLocation?.coordinate.latitude
        let long = currentLocation?.coordinate.longitude
        
        searchVenue(withLat: "\(lat!)", long: "\(long!)")
    case .denied:
      showAlert(title: "Alert", message: "Please allow location services to use this app.")
    case .notDetermined:
      break
    case .restricted:
      break
    }
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    // TODO: return error when necessary
  }
}
