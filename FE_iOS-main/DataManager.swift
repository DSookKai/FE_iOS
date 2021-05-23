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
}
