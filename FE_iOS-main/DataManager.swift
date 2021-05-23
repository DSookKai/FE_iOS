//
//  DataManager.swift
//  FE_iOS-main
//
//  Created by JoSoJeong on 2021/05/23.
//

import Foundation

class DataManager {
    
    
    public func getReady(){
        var request = URLRequest(url: URL(string: "http://18.217.211.176:3000/driver/start/60a8fecd5b86fa941fc123c4")!)
        request.httpMethod = "GET"
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
     
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
        
    }
    
    
    public func getBus(userId: String, courseId: String) {
        
        let url = URL(string: "http://18.217.211.176:3000/driver/board/\(courseId)/\(userId)")

        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        request.setValue(userId, forHTTPHeaderField: "userId")
        request.setValue(courseId, forHTTPHeaderField: "courseId")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Convert HTTP Response Data to a String
            if let data=data, let dataString = String(data: data, encoding: .utf8) {
                
                print("[Rest API] getUserByKey : \(dataString)")
    
                //completionHandler(dataString)
                
            }
        }
        task.resume()
    }
    
    
    
    public func getCourse(completionHandler: @escaping (_ result: Data) -> ()){ //get
        var request = URLRequest(url: URL(string: "http://18.217.211.176:3000/course")!)
        request.httpMethod = "GET"
        request.setValue(" application/json; charset=utf-8", forHTTPHeaderField:"Content-Type")

        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }

            // Convert HTTP Response Data to a String
            if let data = data {
                completionHandler(data)
            }
        }
        task.resume()
    }
    
//    public func travelerInfoPost(completionHandler: @escaping (_ result: Data) -> ()){
//        let params = ["username":"john", "password":"123456"] as Dictionary<String, String>
//
//        let param = "userName=이름이&phoneNum=\(phoneNumber!)&birth=\(birthDay)&location=\(location)"
//                let paramData = param.data(using: .utf8)
//        let paramData = param.data(using: .utf8)
//        let url = URL(string: "http://18.217.211.176:3000/driver/travelerInfo")
//
//
//        var request = URLRequest(url: url!)
//
//        request.httpMethod = "POST"
//        request.httpBody = paramData
//
//
//        // HTTP 메시지 헤더
//       request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//       request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
//
//        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let session = URLSession.shared
//        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
//            if let e = error {
//                       NSLog("An error has occured: \(e.localizedDescription)")
//                       return
//            }else{
//               print("---------")
//               print("h1ppy")
//            }
//        }.resume()
//    }
    
}


