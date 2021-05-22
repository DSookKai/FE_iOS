//
//  LoginViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/22.
//

import UIKit

class LoginViewController: UIViewController {
    

    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var numberTextfield: UITextField!
    
    @IBOutlet weak var driverMode: UIButton!
    
    @IBAction func loginButtonClick(_ sender: Any) {
        //authentication
        
        
    }
    
    let center = UNUserNotificationCenter.current()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        driverMode.addTarget(self, action: #selector(didTapMode), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapMode(){
        driverMode.isSelected = true
        driverMode.setTitleColor(UIColor.systemGray, for: .normal)
       
  
    }
    
 
    

    

}
