//
//  DirectionGMMapController.swift
//  EggMap
//
//  Created by Mei on 2018-10-16.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation

class DirectionGMMapController: UIViewController, CLLocationManagerDelegate {
    
    let alert = UIAlertController()
    let slideUpView = ClientSlideUpView()

    var addressString: String? {
        didSet{
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingLocation()
        }
    }
    //    var clientLocation : LocationAndScheduleByIdDataModel? {
    //        didSet{
    //            let locationById = GetLocationDetailsByIDJSON()
    //            guard let location = clientLocation else {return}
    //            addressString = locationById.formAddressString(location: location)
    //        }
    //    }
    let mapView = GMSMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 18)
        mapView.animate(to: camera)
        
        
        
        
        
        guard let address = addressString else {return}
        geoCodeAddress(address: address, userPoint: center)
    }
    
    private func geoCodeAddress(address: String, userPoint: CLLocationCoordinate2D) {
        var coordinates = CLLocationCoordinate2D()
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                //put an alert here for no placemarks found
                print("GEOCODER: No Placemarks Found!")
            } else {
                guard let unwrappedCoord = placemarks?.first?.location?.coordinate else {return}
                coordinates = unwrappedCoord
                
                //to calculate the distance
                //                let userPoint = MKMapPointForCoordinate(userPoint)
                //                let addressPoint = MKMapPointForCoordinate(coordinates)
                //                let distance = MKMetersBetweenMapPoints(userPoint, addressPoint)
                //                if distance < 100000 {
                let newMarker = GMSMarker(position: coordinates)
                newMarker.title = address
                newMarker.map = self.mapView
                self.mapView.animate(toLocation: coordinates)
                
            }
        }
    }
    
    fileprivate func setupViews() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Abort Order", style: .plain, target: self, action: #selector(handleRightBarButtonTapped))
        self.mapView.isMyLocationEnabled = true
        view.addSubview(mapView)
        mapView.fillSuperview()
    }
    
    @objc func handleRightBarButtonTapped() {
        let alert = UIAlertController(title: "Abort order?", message: "Unless absolutely necessary, we do not encourage aborting an order that is currently processed.", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter reason for aborting order."
        }
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            let orderSummaryController = OrderSummaryScreenController()
            let navOrderSummary = UINavigationController(rootViewController: orderSummaryController)
            self.present(navOrderSummary, animated: true, completion: nil)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true) {
            //completion handler here
        }
    }
}

extension DirectionGMMapController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let rateUser = RateUserController()
        navigationController?.pushViewController(rateUser, animated: true)
        return false
    }
}




//func drawPath(startLocation: CLLocation, endLocation: CLLocation)
//{
//    let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
//    let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
//    
//    
//    let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving"
//    
//    Alamofire.request(url).responseJSON { response in
//        
//        print(response.request as Any)  // original URL request
//        print(response.response as Any) // HTTP URL response
//        print(response.data as Any)     // server data
//        print(response.result as Any)   // result of response serialization
//        
//        let json = JSON(data: response.data!)
//        let routes = json["routes"].arrayValue
//        
//        // print route using Polyline
//        for route in routes
//        {
//            let routeOverviewPolyline = route["overview_polyline"].dictionary
//            let points = routeOverviewPolyline?["points"]?.stringValue
//            let path = GMSPath.init(fromEncodedPath: points!)
//            let polyline = GMSPolyline.init(path: path)
//            polyline.strokeWidth = 4
//            polyline.strokeColor = UIColor.red
//            polyline.map = self.googleMaps
//        }
//        
//    }
//}
