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
    
    @IBOutlet weak var userBirthTextfield: UITextField!
    
    @IBOutlet weak var userNumberTextfield: UITextField!
   
    @IBOutlet weak var authNumber: UITextField!
    
   
    @IBAction func sendAuth(_ sender: Any)
    {
        
    }
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
        
        let webVC = UIStoryboard.init(name: "WebView", bundle: nil).instantiateViewController(withIdentifier: "web")
        //let webNavVC = UINavigationController(rootViewController: webVC)
        webVC.modalPresentationStyle = .fullScreen
        self.present(webVC, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        // Do any additional setup after loading the view.
    }
    



}
