//
//  TrackMyTraceViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/06.
//

import UIKit
import CoreLocation
import MapKit

class TrackMyTraceViewController: UIViewController {

    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userAddress: UILabel!
    @IBOutlet weak var guardian: UILabel!
    
    
    @IBAction func pickUpButton(_ sender: Any) {
        //send message
    }
    @IBOutlet weak var MapView: MKMapView!
    

    @IBOutlet weak var start: UITextField!
    

    @IBOutlet weak var destination: UITextField!
    
    var customerLocation: [(latitude:Double, longitude: Double)] = [(0,0),(37.5506753, 127.0409622),(37.520641,126.9139242)]
    
    lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
        manager.delegate = self
        return manager
     }()
    

    var previousCoordinate: CLLocationCoordinate2D?

    override func viewDidLoad() {
        super.viewDidLoad()

        getLocationUsagePermission()
        // xcode 종료 후 어플을 다시 실행했을 때 뜨는 오류 방지.
        self.MapView.mapType = MKMapType.standard
        // 지도에 내 위치 표시
        MapView.showsUserLocation = true
        // 현재 내 위치 기준으로 지도를 움직임.
        self.MapView.setUserTrackingMode(.follow, animated: true)

        self.MapView.isZoomEnabled = true
        self.MapView.delegate = self
        
        makePin()

        //self.trackData.date = Date()
    }
    
    func makePin(){
        let coords = [CLLocationCoordinate2D(latitude: customerLocation[0].latitude, longitude: customerLocation[0].longitude), CLLocationCoordinate2D(latitude: customerLocation[1].latitude, longitude: customerLocation[1].longitude), CLLocationCoordinate2D(latitude: customerLocation[2].latitude, longitude: customerLocation[2].longitude)]
        
        let findLocation = [CLLocation(latitude: customerLocation[0].latitude, longitude: customerLocation[0].longitude), CLLocation(latitude: customerLocation[1].latitude, longitude: customerLocation[1].longitude), CLLocation(latitude: customerLocation[2].latitude, longitude: customerLocation[2].longitude)]
        
        let geocoder = CLGeocoder()
        let locale = Locale(identifier: "Ko-kr")
        for i in findLocation {
            print(i)
            
          
        }
        

        for i in coords{
            let annotation = MKPointAnnotation()
            annotation.coordinate = i
            annotation.title = "0"
            MapView.addAnnotation(annotation)
        }
        
    }

    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.locationManager.stopUpdatingLocation()
    }



}



extension TrackMyTraceViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else {return}
        let latitude = location.coordinate.latitude
        let longtitude = location.coordinate.longitude
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {
            (placemarks, error) -> Void in
            guard let pm = placemarks!.first else {return}
    
            if pm.locality != nil {
                DispatchQueue.main.async {
                    self.start?.text = pm.thoroughfare!
                }
            }
            
        })


        if let previousCoordinate = self.previousCoordinate {
            var points: [CLLocationCoordinate2D] = []
            let point1 = CLLocationCoordinate2DMake(previousCoordinate.latitude, previousCoordinate.longitude)
            let point2: CLLocationCoordinate2D
            = CLLocationCoordinate2DMake(latitude, longtitude)
            points.append(point1)
            points.append(point2)
            let lineDraw = MKPolyline(coordinates: points, count:points.count)
            self.MapView.addOverlay(lineDraw)
        }

        self.previousCoordinate = location.coordinate

    }
    
   
}

extension TrackMyTraceViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyLine = overlay as? MKPolyline
        else {
            print("can't draw polyline")
            return MKOverlayRenderer()
        }
        let renderer = MKPolylineRenderer(polyline: polyLine)
            renderer.strokeColor = .orange
            renderer.lineWidth = 5.0
            renderer.alpha = 1.0

        return renderer
    }
}

extension CLLocationCoordinate2D {
    //distance in meters, as explained in CLLoactionDistance definition
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let destination=CLLocation(latitude:from.latitude,longitude:from.longitude)
        return CLLocation(latitude: latitude, longitude: longitude).distance(from: destination)
    }
}
