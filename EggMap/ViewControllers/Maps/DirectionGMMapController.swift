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
    
    let gmsHelpers = GMSHelpers()
    
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
    var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        
        //remove POI using styling
        do {
            let kMapStyle = gmsHelpers.kMapStyle
            mapView.mapStyle = try GMSMapStyle(jsonString: kMapStyle)
        } catch {
            print("JSON String did not load")
        }
        
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let center = location.coordinate
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 18)
        mapView.animate(to: camera)
        
        //display userLoc
        self.mapView.isMyLocationEnabled = true
        
        //display destination location
//        guard let address = addressString else {return}
//        let destCoords = geoCodedAddress(address: address)
        
        //test coords
        let destCoords = CLLocationCoordinate2D(latitude: 37.7870, longitude: -122.4025)
        let destMarker = GMSMarker(position: destCoords)
        destMarker.title = "Museum of IceCream"
        destMarker.map = self.mapView
//        self.mapView.animate(toLocation: destCoords)
        
        gmsHelpers.drawPath(startLocation: center, endLocation: destCoords, mapView: self.mapView)
        
        
//        geoCodeAddress(address: address, userPoint: center)
    }
    
    func geoCodedAddress(address: String) -> CLLocationCoordinate2D {
        var coordinates = CLLocationCoordinate2D()
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if error != nil {
                print("GeoCoder: No Placemarks found!")
            } else {
                guard let unwrappedCoord = placemarks?.first?.location?.coordinate else {return}
                coordinates = unwrappedCoord
            }
        }
        return coordinates
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
                
                
                
//                37.7870° N, 122.4052° W
                let destCoords = CLLocationCoordinate2D(latitude: 37.7870, longitude: -122.4025)
                let destinationMarker = GMSMarker(position: destCoords)
                destinationMarker.title = "Museum of Ice Cream"
                destinationMarker.map = self.mapView
                
//                self.gmsHelpers.drawPath(startLocation: coordinates, endLocation: destCoords).map = self.mapView
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
            let orderSummaryController = ClientSideOrderSummaryScreenController()
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
