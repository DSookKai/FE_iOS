//
//  LoginViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/22.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager!
    var latitude: Double?
    var longitude: Double?
    

    @IBOutlet weak var birthTextfield: UITextField!
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    @IBOutlet weak var driverMode: UIButton!
    
    @IBAction func loginButtonClick(_ sender: Any) {
        //authentication
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
    
    let center = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        driverMode.addTarget(self, action: #selector(didTapMode), for: .touchUpInside)
        locationManager = CLLocationManager()
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapMode(){
        driverMode.isSelected = true
        driverMode.setTitleColor(UIColor.systemGray, for: .normal)
       
  
    }
    
 
    

    

}
