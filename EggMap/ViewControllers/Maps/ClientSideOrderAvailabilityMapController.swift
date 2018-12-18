//
//  ClientSideOrderAvailabilityMapController.swift
//  EggMap
//
//  Created by Mei on 2018-10-06.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps
import MapKit
import CoreLocation
import SwiftyJSON
import Alamofire

class ClientSideOrderAvailabilityMapController: UIViewController, CLLocationManagerDelegate {
    
    //GMMAP variables
    var tappedMarker = GMSMarker()
    var customInfoWindow : MapMarkerInfoWindow?
    
    var slideInFromRightView : ClientSlideInCollectionView!
    var slideUpView: ClientSlideUpView!
    
    lazy var agentMarkerImage: UIImageView = {
        let image = UIImageView()
        //give it a frame/cgrect for it to show up
        image.frame = CGRect(x: 0, y: 0, width: ScreenSize.height * 0.05, height: ScreenSize.height * 0.05)
        let img = UIImage(named: "highlightedStar")?.withRenderingMode(.alwaysTemplate)
        image.image = img
        //DONT KNOW IF WE NEED THIS AT ALL YET
//        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleAgentMarkerTapped)))
        return image
    }()
    
    lazy var storeMarkerImage: UIImageView = {
        let image = UIImageView()
        //give it a frame/cgrect for it to show up
        image.frame = CGRect(x: 0, y: 0, width: ScreenSize.height * 0.05, height: ScreenSize.height * 0.05)
        let img = UIImage(named: "Cartoon Egg")?.withRenderingMode(.alwaysTemplate)
        image.image = img
        //DONT KNOW IF WE NEED THIS AT ALL YET
//        image.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleStoreMarkerTapped)))
        return image
    }()
    
    lazy var optionSegmentController : UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Map", "List"])
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .white
        sc.addTarget(self, action: #selector(handleSCValueChanged), for: .valueChanged)
        return sc
    }()
    
    var navRightButtonBool: Bool = false    
    var addressString: String? {
        didSet{
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
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
    lazy var mapView = GMSMapView()
    let locationManager = CLLocationManager()
    let buttonContainer: UIView = {
        
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        ClientSlideUpView.shared?.delegate = self
        slideUpView.directionButton.setTitle("Contact", for: .normal)
        mapView.delegate = self
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
                //custom image for marker
                newMarker.iconView = self.agentMarkerImage
                newMarker.title = address
                newMarker.map = self.mapView
                self.mapView.animate(toLocation: coordinates)
                
//                let agentMarker = GMSMarker(position: coordinates)
//                //custom image for marker
//                agentMarker.iconView = self.agentMarkerImage
//                agentMarker.title = address
//                agentMarker.map = self.mapView
                
                //custom image for store
                let storeMarker = GMSMarker()
//                storeMarker.position = CLLocationCoordinate2D(latitude: 49.1844, longitude: -123.1052)
                storeMarker.position = CLLocationCoordinate2D(latitude: 49.1844, longitude: -123.1052)
                storeMarker.iconView = self.storeMarkerImage
                storeMarker.title = "Store"
                storeMarker.map = self.mapView
//                self.mapView.animate(toLocation: storeMarker.position)
                
                //to display user's coordinates
                //                    self.mapView.isMyLocationEnabled = true
                //                }
               

//                let location1 = CLLocation(latitude: 49.1721, longitude: -123.0764)
//                let location2 = CLLocation(latitude: 49.1844, longitude: -123.1052)
//                self.drawPath(startLocation: coordinates, endLocation: storeMarker.position)
//                self.drawPath2(origin: coordinates, destination: storeMarker.position)
//                self.draw3(origin: coordinates, destination: storeMarker.position)

            }
        }
    }
    
    fileprivate func setupViews() {
        view.addSubview(mapView)
        view.addSubview(optionSegmentController)
        
        //user location button
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
    
        mapView.anchor(optionSegmentController.topAnchor, left: self.view.safeAreaLayoutGuide.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        setupSlideUpView()
        setupSlideInColletionView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Come To Me", style: .plain, target: self, action: #selector(navRightButtonTapped))
        navigationItem.rightBarButtonItem?.tag = 001
        optionSegmentController.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: ScreenSize.height * 0.07)
    }
    
    @objc func navRightButtonTapped() {
        self.slideUpView.locationTypeImage.isHidden = true
        self.slideUpView.locationNameLabel.isHidden = true
        self.slideUpView.starRating.isHidden = true
        self.slideUpView.datePicker.isHidden = false
        self.slideUpView.directionButton.setTitle("Send", for: .normal)
        if navRightButtonBool == false {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                print("slide up button pressed = \(self.navRightButtonBool)")
                self.slideUpView.frame.origin.y = ScreenSize.height * 0.75
            }) { (_) in
                //completion handler
            }
            navRightButtonBool = true
        
       }  else { 
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                print("slide up button pressed = \(self.navRightButtonBool)")
                self.slideUpView.frame.origin.y = self.view.frame.maxY
            }) { (_) in
                //completion handler
            }
            navRightButtonBool = false
        }
    }
    
    //WE MIGHT NOT NEED THESE
//    @objc func handleAgentMarkerTapped() {
//        print("Image has been tapped!!!")
//    }
//
//    @objc func handleStoreMarkerTapped() {
//        print("StoreMarkerTapped")
//    }
    
}

//slide up view
extension ClientSideOrderAvailabilityMapController {
    
    private func setupSlideUpView() {
        slideUpView = ClientSlideUpView(frame: CGRect(x: 0, y: self.view.frame.maxY, width: self.view.frame.width, height: self.view.frame.height))
        view.addSubview(slideUpView)
        
        //ADD A SWIPE UP GESTURE RECOGNIZER LATER
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(gesture:)))
        swipeDown.direction = .down
        slideUpView.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {

        //ADD A SWIPE UP CASE LATER
            
        case .down:
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideUpView.frame.origin.y = self.view.frame.maxY
            }) { (_) in
                //completion handler
                self.slideUpView.locationTypeImage.image = nil
                self.slideUpView.locationNameLabel.text = nil
                self.slideUpView.directionButton.setTitle("", for: .normal)
//                self.slideUpView.starRating. = false
            }
        default:
            print("No Swipes")
        }
    }
}

//slide in from the left side collectionView
extension ClientSideOrderAvailabilityMapController {
    
    private func setupSlideInColletionView() {
        slideInFromRightView = ClientSlideInCollectionView(frame: CGRect(x: 0, y: self.optionSegmentController.frame.maxY, width: 0, height: self.view.frame.height))
        view.addSubview(slideInFromRightView)
    }
    
    @objc func handleSCValueChanged() {
        
        if self.optionSegmentController.selectedSegmentIndex == 1 {
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideInFromRightView.frame = CGRect(x: 0, y: self.optionSegmentController.frame.maxY, width: self.view.frame.width, height: self.view.frame.height)
            }) { (_) in
                //completion handler
            }
        } else {
            UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideInFromRightView.frame = CGRect(x: 0, y: self.optionSegmentController.frame.maxY, width: 0, height: self.view.frame.height)
            }) { (_) in
                //completion handler
            }
        }
    }
}

extension ClientSideOrderAvailabilityMapController: handleViewButtonsDelegate {
    func handleContactButtonPressed(sender: UIButton) {
        print("View Button has been pressed")
        if slideUpView.directionButton.titleLabel?.text == "Send" {
            let waitingForAgents = WaitingForAgentsController()
            let navWaiting = UINavigationController(rootViewController: waitingForAgents)
            self.present(navWaiting, animated: true) {
                //completion handler here
            }
        } else {
            if slideUpView.directionButton.title(for: .normal) == "Directions" {
                let directionMap = DirectionGMMapController()
                navigationController?.pushViewController(directionMap, animated: true)
            } else {
                let layout = UICollectionViewFlowLayout()
                let chatController = ChatViewController(collectionViewLayout: layout)
                navigationController?.pushViewController(chatController, animated: true)
            }
        }
        
    }
}

//tap markers
extension ClientSideOrderAvailabilityMapController: GMSMapViewDelegate {

    //reset custom infoWindow whenever marker is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if marker.iconView == self.agentMarkerImage {
            print("Agent Profile")
            slideUpView.directionButton.setTitle("Contact", for: .normal)
            self.slideUpView.locationTypeImage.isHidden = false
            self.slideUpView.locationNameLabel.isHidden = false
            self.slideUpView.starRating.isHidden = false
            self.slideUpView.datePicker.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideUpView.frame.origin.y = ScreenSize.height * 0.75
            }) { (_) in
                //completion handler
            }
        } else {
            
            print("Store Profile")
            slideUpView.directionButton.setTitle("Directions", for: .normal)
            self.slideUpView.locationTypeImage.isHidden = false
            self.slideUpView.locationNameLabel.isHidden = false
            self.slideUpView.starRating.isHidden = false
            self.slideUpView.datePicker.isHidden = true
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.slideUpView.frame.origin.y = ScreenSize.height * 0.75
            }) { (_) in
                //completion handler
            }
            
        }
        //return false so button event is still handled by delegate
        return false
        
    }
    
    //make the custom infoWindow follow the camera
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if tappedMarker.userData != nil {
            //location of tapped marker here
            let location = CLLocationCoordinate2D(latitude: tappedMarker.position.latitude, longitude: tappedMarker.position.longitude)
            customInfoWindow?.center = mapView.projection.point(for: location)
        }
    }
    
    //take care of the closing event
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.slideUpView.frame.origin.y = self.view.frame.maxY
        }) { (_) in
            //completion handler
        }
    }
    
    @objc func infoBtnTapped() {
        print("Info window button pressed...")
    }
    
}

//private func drawPath(startLocation: CLLocationCoordinate2D, endLocation: CLLocationCoordinate2D) {
//    let origin = "\(startLocation.latitude),\(startLocation.longitude)"
//    let destination = "\(endLocation.latitude),\(endLocation.longitude)"
//
//    let prefTravel = "driving"
//    let apiKey = "AIzaSyCDjc5onKz4Tvf_Z7uyVMHg7idums2JlN8"
//
//    let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(prefTravel)&key=\(apiKey)")
//
//    Alamofire.request(url!).responseJSON { response in
//
//        print(response.request as Any)  // original URL request
//        print(response.response as Any) // HTTP URL response
//        print(response.data as Any)     // server data
//        print(response.result as Any)   // result of response serialization
//        do {
//            let json = try JSON(data: response.data!)
//            let routes = json["routes"].arrayValue
//            print(routes.count)
//            // print route using Polyline
//            for route in routes
//            {
//                let routeOverviewPolyline = route["overview_polyline"].dictionary
//                let points = routeOverviewPolyline?["points"]?.stringValue
//                let path = GMSPath.init(fromEncodedPath: points!)
//                let polyline = GMSPolyline.init(path: path)
//                polyline.strokeWidth = 4
//                polyline.strokeColor = UIColor.blue
//                polyline.map = self.mapView
//            }
//        } catch let err {
//            print(err)
//        }
//    }
//}
//
//func drawPath2(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D)
//{
//    let origin = "\(origin.latitude),\(origin.longitude)"
//    let destination = "\(destination.latitude),\(destination.longitude)"
//    let apiKey = "AIzaSyAOhiBw8mSPBmmAJQ_fjM79x7ruvMxFmxQ"
//
//    //        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=AIzaSyAOhiBw8mSPBmmAJQ_fjM79x7ruvMxFmxQ"
//    guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&key=AIzaSyCDjc5onKz4Tvf_Z7uyVMHg7idums2JlN8") else {return}
//
//    Alamofire.request(url).responseJSON { response in
//        print(response.request)  // original URL request
//        print(response.response) // HTTP URL response
//        print(response.data)     // server data
//        print(response.result)   // result of response serialization
//
//        let json = try! JSON(data: response.data!)
//        let routes = json["routes"].arrayValue
//
//        //remove this after test
//        print(routes.count)
//
//        for route in routes
//        {
//            let routeOverviewPolyline = route["overview_polyline"].dictionary
//            let points = routeOverviewPolyline?["points"]?.stringValue
//            let path = GMSMutablePath.init(fromEncodedPath: points!)
//            let polyline = GMSPolyline.init(path: path)
//            polyline.map = self.mapView
//        }
//    }
//}
//
//private func draw3(origin: CLLocationCoordinate2D, destination: CLLocationCoordinate2D) {
//    //Here you need to set your origin and destination points and mode
//    //            let url = NSURL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=Machilipatnam&destination=Vijayawada&mode=driving")
//
//    //OR if you want to use latitude and longitude for source and destination
//    //            let url = NSURL(string: "\("https://maps.googleapis.com/maps/api/directions/json")?origin=\("17.521100"),\("78.452854")&destination=\("15.1393932"),\("76.9214428")")
//
//    let origin = "\(origin.latitude),\(origin.longitude)"
//    let destination = "\(destination.latitude),\(destination.longitude)"
//
//    let prefTravel = "driving"
//    let apiKey = "AIzaSyA8ebrZt_wFGskWjpsHD_xLDS-I580zYEU"
//
//    let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=\(prefTravel)&key=AIzaSyCDjc5onKz4Tvf_Z7uyVMHg7idums2JlN8")
//
//    let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) -> Void in
//
//        do {
//            if data != nil {
//                let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves) as!  [String:AnyObject]
//                print(dic)
//
//                let status = dic["status"] as! String
//                var routesArray:String!
//                if status == "OK" {
//                    routesArray = (((dic["routes"]! as! [Any])[0] as! [String:Any])["overview_polyline"] as! [String:Any])["points"] as? String
//                }
//
//                DispatchQueue.main.async {
//                    guard let path = GMSPath.init(fromEncodedPath: routesArray!) else {return}
//                    let singleLine = GMSPolyline.init(path: path)
//                    singleLine.strokeWidth = 6.0
//                    singleLine.strokeColor = .blue
//                    singleLine.map = self.mapView
//                }
//
//            }
//        } catch {
//            print("Error")
//        }
//    }
//
//    task.resume()
//}
