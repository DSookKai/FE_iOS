//
//  WebViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //"18.217.211.176:3000/course"
        //loadWebPage("18.217.211.176:3000/course")
    }
    
  
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url:myUrl!)
        webView.load(myRequest)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
