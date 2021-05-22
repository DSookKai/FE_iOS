//
//  CourseViewController.swift
//  FE_iOS-main
//
//  Created by 김수경 on 2021/05/22.
//
import UIKit
import MapKit
import CoreLocation

class CourseViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var customerLocation: [(latitude:Double, longitude: Double)] = [(0,0),(37.5506753, 127.0409622),(37.520641,126.9139242)]
    //customerLocation += (37.5506753, 127.0409622)
    var customerLocationName = [String](repeating: "", count:5)
    
    
    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblCurrentLocation: UILabel!
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            var annotationView = MKMarkerAnnotationView()
           
        switch  annotation.coordinate.latitude {
        case customerLocation[0].latitude:
            self.lblCurrentLocation.text = "0"
        case customerLocation[1].latitude:
            self.lblCurrentLocation.text = "1"
        case customerLocation[2].latitude:
            self.lblCurrentLocation.text = "2"
        default:
            self.lblCurrentLocation.text = "no"
        }
           
            return annotationView
        }
    
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
        annotation.title = strTitle
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
            
        })
        locationManager.stopUpdatingLocation()
        
//        for i in 0..<customerLocation.count {
//
//            _ = goLocation(latitudeValue: customerLocation[i].latitude, longitudeValue: customerLocation[i].longitude, delta: 0.01)
//
//            CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
//                (placemarks, error) -> Void in
//                let pm = placemarks!.first
//                let country = pm!.country
//                var address:String = country!
//                if pm!.locality != nil {
//                    address += " "
//                    address += pm!.thoroughfare!
//                    self.customerLocationName.append(_: address)
//                }
//
//
//
//
//                self.lblCurrentLocation.text="현재 위치: " + address
//
//
//            })
        
            
            
            locationManager.stopUpdatingLocation()
//
        //}
        
        placePins()
        
    
    }
    
    func placePins() {
       
      
        let coords = [CLLocationCoordinate2D(latitude: customerLocation[0].latitude, longitude: customerLocation[0].longitude), CLLocationCoordinate2D(latitude: customerLocation[1].latitude, longitude: customerLocation[1].longitude), CLLocationCoordinate2D(latitude: customerLocation[2].latitude, longitude: customerLocation[2].longitude)]
        
        
        
        
      
        for i in coords.indices {
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coords[i]
            let findLocation = CLLocation(latitude:customerLocation[i].latitude, longitude: customerLocation[i].longitude)
            let geocoder = CLGeocoder()
            let locale = Locale(identifier: "Ko-kr")
            geocoder.reverseGeocodeLocation(findLocation, preferredLocale: locale, completionHandler: {(placemarks, error) in
                if let address: [CLPlacemark] = placemarks {
                    
                        if let name: String = address.last?.name   {
                            print(String(i) + "     " + name)
                            self.customerLocationName[i] = name
                            //self.customerLocationName.insert(name, at: i)
                            print(self.customerLocationName)
                            //self.lblCurrentLocation.text = self.customerLocationName[i]
                           
                    }
                   
                    
                }
                
                    
            })
            //annotation.title = self.customerLocationName[i]
            
            
            
            myMap.addAnnotation(annotation)
            switch  annotation.coordinate.latitude {
            case self.customerLocation[0].latitude:
                self.lblCurrentLocation.text = "0"
            case self.customerLocation[1].latitude:
                self.lblCurrentLocation.text = "1"
            case self.customerLocation[2].latitude:
                self.lblCurrentLocation.text = "2"
            default:
                self.lblCurrentLocation.text = "no"
            }
            
            //lblCurrentLocation.text = "주소: " + customerLocationName[i]
            
        }
       
       
    }

 

}

