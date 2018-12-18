//
//  GMSHelpers.swift
//  EggMap
//
//  Created by Mei on 2018-12-16.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire

class GMSHelpers {
    
    // MARK: JSON to get rid of POI markers
    let kMapStyle = "[" +
        "  {" +
        "    \"featureType\": \"poi.business\"," +
        "    \"elementType\": \"all\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }," +
        "  {" +
        "    \"featureType\": \"transit\"," +
        "    \"elementType\": \"labels.icon\"," +
        "    \"stylers\": [" +
        "      {" +
        "        \"visibility\": \"off\"" +
        "      }" +
        "    ]" +
        "  }" +
    "]"
    
    // MARK: function that draws a polylin from 1 marker to another returns a stringValue to be used for GMSPath.init(fromEncodedPath: points)
    func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D, mapView: GMSMapView) {
        let origin = "\(startLocation.latitude),\(startLocation.longitude)"
        let destination = "\(endLocation.latitude),\(endLocation.longitude)"
        let prefTravel = "driving"
        let apiKey = "AIzaSyCDjc5onKz4Tvf_Z7uyVMHg7idums2JlN8"
        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(prefTravel)&key=\(apiKey)")
        
        Alamofire.request(url!).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            do {
                let json = try JSON(data: response.data!)
                let routes = json["routes"].arrayValue
                print(routes.count)
                // print route using Polyline
                for route in routes
                {
                    let routeOverviewPolyline = route["overview_polyline"].dictionary
                    guard let points = routeOverviewPolyline?["points"]?.stringValue else {return}
                    guard let path = GMSPath.init(fromEncodedPath: points) else {return}
                    let polyline = GMSPolyline.init(path: path)
                    polyline.strokeWidth = 4
                    polyline.strokeColor = UIColor.blue
                    polyline.map = mapView
                }
            } catch let err {
                print(err)
            }
        }
    }
    
}
