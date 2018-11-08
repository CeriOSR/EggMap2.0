//
//  GMSMapController.swift
//  EggMap
//
//  Created by Rey Cerio on 2018-07-08.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation

class GMSMapController: UIViewController, CLLocationManagerDelegate {
    
    
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
    let buttonContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let button1: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.setTitle("Button ", for: .normal)
        return button
    }()
    
    let button2: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.setTitle("Button 2", for: .normal)
        return button
    }()
    
    let button3: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.backgroundColor = .green

        button.setTitle("Button 3", for: .normal)
        return button
    }()
    
    let button4: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.masksToBounds = true
        button.backgroundColor = .yellow
        button.setTitle("Button 4", for: .normal)
        return button
    }()
    
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
                //to display user's coordinates
//                    self.mapView.isMyLocationEnabled = true
//                }
            }
        }
    }
    
    fileprivate func setupViews() {
        view.addSubview(mapView)
        view.addSubview(buttonContainer)
        buttonContainer.addSubview(button1)
        buttonContainer.addSubview(button2)
        buttonContainer.addSubview(button3)
        buttonContainer.addSubview(button4)

        buttonContainer.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.125)
        
        mapView.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: buttonContainer.topAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        mapView.isMyLocationEnabled = true
        
        button1.anchor(buttonContainer.topAnchor, left: buttonContainer.leftAnchor, bottom: buttonContainer.centerYAnchor, right: buttonContainer.centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        button2.anchor(buttonContainer.topAnchor, left: buttonContainer.centerXAnchor, bottom: buttonContainer.centerYAnchor, right: buttonContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        button3.anchor(button1.bottomAnchor, left: buttonContainer.leftAnchor, bottom: buttonContainer.bottomAnchor, right: buttonContainer.centerXAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

        button4.anchor(button1.bottomAnchor, left: buttonContainer.centerXAnchor, bottom: buttonContainer.bottomAnchor, right: buttonContainer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
}
