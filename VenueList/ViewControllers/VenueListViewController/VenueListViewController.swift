//
//  ViewController.swift
//  VenueList
//
//  Created by Keith Mark Samson on 19/12/2018.
//  Copyright © 2018 Keith Mark Samson. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

fileprivate let BASE_REQUEST_URL = "https://api.foursquare.com/v2"
fileprivate let CLIENT_ID = "GV3MMILBCDYQBQMAQN45JCYUENGJU1AVFFVFX3RSIV4FCU0C"
fileprivate let CLIENT_SECRET = "PFO01BN4UHZDH5VJJOJNFK34YTWSEJJIX0LVP1HRN0R2WZNY"
fileprivate let API_VERSION = "20181219"
fileprivate let TEST_LAT = 14.558929
fileprivate let TEST_LONG = 121.01643113

class VenueListViewController: UIViewController {

  let locManager = CLLocationManager()
  var currentLocation: CLLocation?
  
  var venueArray: [Venue]? = [] {
    didSet {
      DispatchQueue.main.async {
        SVProgressHUD.dismiss()
        self.mainView?.venueTableView.reloadData()
      }
    }
  }
  
  var mainView: VenueListView?
  
  override func loadView() {
    mainView = VenueListView()
    view = mainView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let mainView = mainView else {
      return
    }
    
    mainView.venueTableView.delegate = self
    mainView.venueTableView.dataSource = self
    
    locManager.delegate = self
    locManager.requestWhenInUseAuthorization()
    locManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
  }
  
  // MARK: Helper Methods

  func searchVenue(withLat lat:String, long: String) {
    let url = "\(BASE_REQUEST_URL)/venues/search?ll=\(lat),\(long)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(API_VERSION)"
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    let session = URLSession.shared
    
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
      self.venueArray = self.getVenuesFromData(data)
    })
    SVProgressHUD.show()
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
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(action)
    present(alert, animated: true, completion: nil)
  }

}
