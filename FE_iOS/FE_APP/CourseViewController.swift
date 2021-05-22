


// CourseViewController.swift
// FE_iOS-main
//
// Created by 김수경 on 2021/05/22.
//
import UIKit
import MapKit
import CoreLocation
class CourseViewController: UIViewController, CLLocationManagerDelegate {
  let locationManager = CLLocationManager()
  var customerLocation: [(latitude:Double, longitude: Double)] = [(0,0),(37.5506753, 127.0409622),(37.520641,126.9139242)]
  //customerLocation += (37.5506753, 127.0409622)
  var customerLocationName: [String] = []
  @IBOutlet var myMap: MKMapView!
  @IBOutlet var lblCurrentLocation: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    lblCurrentLocation.text = ""
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    myMap.showsUserLocation = true
  }
    
  func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D {
    let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
    let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
    let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
    myMap.setRegion(pRegion, animated: true)
    customerLocation[0].latitude = latitudeValue
    customerLocation[0].longitude = longitudeValue
    return pLocation
  }
    
  func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle:String){
    let annotation = MKPointAnnotation()
    annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
    annotation.title=strTitle
    annotation.subtitle = strSubtitle
    myMap.addAnnotation(annotation)
  }
    
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let pLocation = locations.last
    _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
    CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
      (placemarks, error) -> Void in
      let pm = placemarks!.first
      let country = pm!.country
      var address:String = country!
      if pm!.locality != nil {
        address += " "
        address += pm!.thoroughfare!
      }
      self.lblCurrentLocation.text="현재 위치: " + address
    })
    locationManager.stopUpdatingLocation()
//    for i in 0..<customerLocation.count {
//
//      _ = goLocation(latitudeValue: customerLocation[i].latitude, longitudeValue: customerLocation[i].longitude, delta: 0.01)
//
//      CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
//        (placemarks, error) -> Void in
//        let pm = placemarks!.first
//        let country = pm!.country
//        var address:String = country!
//        if pm!.locality != nil {
//          address += " "
//          address += pm!.thoroughfare!
//          self.customerLocationName.append(_: address)
//        }
//
//
//
//
//        self.lblCurrentLocation.text="현재 위치: " + address
//
//
//      })
      //locationManager.stopUpdatingLocation()
//      setAnnotation(latitudeValue: customerLocation[i].latitude, longitudeValue: customerLocation[i].longitude, delta: 1, title: "!", subtitle: "여기에요")
    //}
    placePins()
  }
  func placePins() {
    let coords = [CLLocationCoordinate2D(latitude: customerLocation[0].latitude, longitude: customerLocation[0].longitude), CLLocationCoordinate2D(latitude: customerLocation[1].latitude, longitude: customerLocation[1].longitude), CLLocationCoordinate2D(latitude: customerLocation[2].latitude, longitude: customerLocation[2].longitude)]
    for i in coords.indices {
      let annotation = MKPointAnnotation()
      annotation.coordinate = coords[i]
      let findLocation = CLLocation(latitude: coords[i].latitude, longitude: coords[i].longitude)
      let geocoder = CLGeocoder()
      let locale = Locale(identifier: "Ko-kr")
      geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
        if let address: [CLPlacemark] = placemarks {
            
          if let name: String = address.last?.name {
            print(name)
            self.customerLocationName.append(name)
            print(self.customerLocationName)
          }
        }
      })
      //annotation.title = customerLocationName[i]
      myMap.addAnnotation(annotation)
      //lblCurrentLocation.text = "주소: " + customerLocationName[i]
    }
    print(customerLocationName)
  }
}
