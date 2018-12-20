//
//  ViewController.swift
//  VenueList
//
//  Created by Keith Mark Samson on 19/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit
import CoreLocation

let BASE_REQUEST_URL = "https://api.foursquare.com/v2"
let CLIENT_ID = "GV3MMILBCDYQBQMAQN45JCYUENGJU1AVFFVFX3RSIV4FCU0C"
let CLIENT_SECRET = "PFO01BN4UHZDH5VJJOJNFK34YTWSEJJIX0LVP1HRN0R2WZNY"
let API_VERSION = "20181219"
let TEST_LAT = 14.558929
let TEST_LONG = 121.01643113

class VenueListViewController: UIViewController {

  let locManager = CLLocationManager()
  var currentLocation: CLLocation?
  
  var venueArray: [Venue]? = [] {
    didSet {
      DispatchQueue.main.async {
        self.mainView?.venueTableView.reloadData()
      }
    }
  }
  
  var mainView: VenueListView?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mainView = VenueListView()
    mainView?.venueTableView.delegate = self
    mainView?.venueTableView.dataSource = self
    view = mainView
    
    locManager.delegate = self
    locManager.requestWhenInUseAuthorization()
    locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }

  private func searchVenue(withLat lat:String, long: String) {
    let url = "\(BASE_REQUEST_URL)/venues/search?ll=\(lat),\(long)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(API_VERSION)"
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    let session = URLSession.shared
    
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
      self.venueArray = self.getVenuesFromData(data)
    })
    
    task.resume()
  }
  
  private func getVenuesFromData(_ data: Data?) -> [Venue]? {
    if let _ = data {
      do {
        var venueResponse: GetVenueResponse?
        try venueResponse = JSONDecoder().decode(GetVenueResponse.self, from: data!)
        return venueResponse?.response?.venues
      } catch {
        return []
      }
    }
    return []
  }

}


// MARK: UITableViewDelegate Methods

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
    navigationController?.pushViewController(venueDetailsVC, animated: true)
  }
}

// MARK: UITableViewDataSource Methods

extension VenueListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return venueArray!.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}

// MARK: CLLocationManagerDelegate Methods

extension VenueListViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    currentLocation = manager.location
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    let locationAuthStatus = CLLocationManager.authorizationStatus()
    if(locationAuthStatus == .authorizedWhenInUse || locationAuthStatus ==  .authorizedAlways){
      currentLocation = manager.location
      
      let lat = currentLocation?.coordinate.latitude
      let long = currentLocation?.coordinate.longitude
      
      searchVenue(withLat: "\(lat!)", long: "\(long!)")
    }
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    // TODO: return error when necessary
  }
}
