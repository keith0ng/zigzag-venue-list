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

class ViewController: UIViewController {

  let locManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    locManager.requestWhenInUseAuthorization()
    locManager.delegate = self
    
    let lat = 14.558929
    let long = 121.01643113
    searchVenue(withLat: "\(lat)", long: "\(long)")
  }

  func searchVenue(withLat lat:String, long: String) {
    let url = "\(BASE_REQUEST_URL)/venues/search?ll=\(lat),\(long)&client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=\(API_VERSION)"
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    let session = URLSession.shared
    
    request.httpMethod = "GET"
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
      let json = self.dataToJSON(data: data)
      print("Sample Data: \(json!)")
    })
    
    task.resume()
  }
  
  func dataToJSON(data: Data?) -> [String: Any]? {
    var jsonReturn: [String: Any]?
    let errorReturn = ["Error":"Error parsing"]
    if let _ = data {
      do {
        try jsonReturn = JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
        return jsonReturn
      } catch {
        return errorReturn
      }
    }
    return errorReturn
  }
}

// MARK: CLLocationManagerDelegate Methods

extension ViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    // TODO: set current location variable
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    // TODO: set current location variable
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    // TODO: return error when necessary
  }
}
