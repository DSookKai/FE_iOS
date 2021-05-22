//
//  ViewController.swift
//  FE_APP
//
//  Created by JoSoJeong on 2021/05/22.
//

import UIKit
import Foundation
import MapKit

public struct Queue<T> {
  fileprivate var array = [T]()

  public var isEmpty: Bool {
    return array.isEmpty
  }
  
  public var count: Int {
    return array.count
  }

  public mutating func enqueue(_ element: T) {
    array.append(element)
  }
  
  public mutating func dequeue() -> T? {
    if isEmpty {
      return nil
    } else {
      return array.removeFirst()
    }
  }
  
  public var front: T? {
    return array.first
  }
}

class ViewController: UIViewController {

    var start = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.313294)
    var destination = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.423294)
    
    var node1 = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.413294)
    var node2 = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.433294)
    var node3 = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.453294)
    var node4 = CLLocationCoordinate2D(latitude: 127.269311, longitude: 37.473294)
    var visited: Array<Bool> = [false, false, false, false, false, false]
    var myQueue = Queue<[Int]>()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nodes:[CLLocationCoordinate2D] = [start, node1, node2, node3, node4, destination]
        let nodeInt: [[Int]] = [[1,2,3,4,5], [2,3,4,5], [3,4,5], [4,5], [5], [0,1,2,3,4]]
        

        
        
        var minIndex: Int = 0
        var result: Double = 0.0
        
        while(minIndex != nodes.count - 1){
            var i = minIndex
            var min: Double = 100000
            while(i < nodes.count - 1){
                let cmp:Int = i + 1
                

                if(min > nodes[i].distance(from: nodes[cmp])){
                    min = nodes[i].distance(from: nodes[cmp])
                    minIndex = i
                }
                i = i + 1;
            }
            
            result += min
            
            print(minIndex)
            print(min)
        }
        print(result)
        
        
        //print(bfs(start: 0, nodeInt: nodeInt, nodes: nodes))
    }
    
    var cost:Double = 0;

//    func bfs (start: Int, nodeInt: [[Int]], nodes: [CLLocationCoordinate2D]) -> Double {
//        myQueue.enqueue(nodeInt[start])
//        visited[start] = true
//        while !myQueue.isEmpty {
//
//            guard let a = myQueue.dequeue() else { return 0 }
//            print(a)
//            for i in a {
//                if !visited[i] {
//                    print(i)
//                    print(nodes[start].distance(from: nodes[i]))
//
//                    if a.firstIndex(of: i) == 0 {
//                        cost += nodes[start].distance(from: nodes[i])
//                        myQueue.enqueue(nodeInt[i])
//                        visited[i] = true
//                        continue
//                    }
//
//                    if(cost > nodes[start].distance(from: nodes[i]) ){
//                        cost += nodes[start].distance(from: nodes[i])
//                        print("cost :\(cost)")
//                        myQueue.enqueue(nodeInt[i])
//                        visited[i] = true
//                    }
//                }
//            }
//        }
//        return cost
//    }
//
    
}


extension CLLocationCoordinate2D {
    //distance in meters, as explained in CLLoactionDistance definition
    func distance(from: CLLocationCoordinate2D) -> CLLocationDistance {
        let destination=CLLocation(latitude:from.latitude,longitude:from.longitude)
        return CLLocation(latitude: latitude, longitude: longitude).distance(from: destination)
    }
}
