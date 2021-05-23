//
//  ShowViewController.swift
//  FE_iOS-main
//
//  Created by JoSoJeong on 2021/05/23.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
   
    var courses: [course] = []
    var dataManager: DataManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addCourse()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager = DataManager()
       
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ShowTableViewCell.nib(), forCellReuseIdentifier: ShowTableViewCell.identifier)
    }
    
    func addCourse(){
        dataManager.getCourse() { [self]
            result in
            do {
//                var timeText: Int = 0
//                var name:String = ""
//                var carNum:String = ""
//                var dateText:Int = 0
                if let coursesGroup = try JSONSerialization.jsonObject(with: result) as? [Dictionary<String, Any>] {
                   
                    for cs in coursesGroup {

                        guard let timeText = (cs["courseTime"] as? NSString)?.intValue else { return }
                        
                        guard let name = (cs["courseName"] as? String) else {
                            return
                        }
                        guard let carNum = (cs["carNumber"] as? NSString)?.intValue else { return }
         
                        guard let dateText = (cs["date"] as? NSString)?.intValue else { return }
                        
//                        print(type(of: timeText))
//                        print(type(of: name))
//                        print(type(of: carNum))
//                        print(type(of: dateText))
//
////                        print(timeText)
////                        print(name)
////                        print(carNum)
////                        print(dateText)
//
                        let course = course(courseName: name, courseTime: Int(timeText), carNumber: Int(carNum), date: Int(dateText), companionHas: false, guaridanHas: true)
                        self.courses.append(course)
                            
                        DispatchQueue.main.async {
                            self.tableview?.reloadData()
                        }
                    }
                }
                    
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
        }
    }

}

extension ShowViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.identifier) as! ShowTableViewCell

        cell.configure(model: courses[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let temp = self.storyboard?.instantiateViewController(identifier: "track"){
            self.navigationController?.pushViewController(temp, animated: true)
        }
        
    }
}



