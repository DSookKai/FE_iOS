//
//  FirstViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/23.
//

import UIKit

class FirstViewController: UIViewController {
    

    @IBAction func startButton(_ sender: Any) {
        print("re")
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "login")
        loginVC?.modalPresentationStyle = .fullScreen
        self.present(loginVC!, animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

  
        let attributedString = NSMutableAttributedString(string: " 찾아가는 경로당에\n처음이신가요?", attributes: [
          .foregroundColor: UIColor.orange
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor(white: 51.0 / 255.0, alpha: 1.0), range: NSRange(location: 9, length: 9))

        titleText.attributedText = attributedString
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
