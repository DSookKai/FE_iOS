//
//  SignUpViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/22.
//

import UIKit
import CoreLocation
class SignUpViewController: UIViewController , CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    var latitude: Double?
    var longitude: Double?
    
    @IBOutlet weak var userNameTextfield: UITextField!
    
    @IBOutlet weak var userNumberTextfield: UITextField!
    @IBOutlet weak var uidatePicker: UIDatePicker!
    
    @IBAction func didDoneSignup(_ sender: Any) {
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        //print("dddddddddd" + String(latitude!))
        //서버로 사용자 현재 위치 latitude, longitude넘기면 됨!!
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        // Do any additional setup after loading the view.
    }
    



}
