//
//  Model.swift
//  FE_iOS-main
//
//  Created by JoSoJeong on 2021/05/23.
//

import Foundation
import CoreLocation
import MapKit
struct user {
    var userName: String
    var birth: String
    var myNumber: [String] //0: 본인번호, 1: 보호자번호
    var location:  CLLocationCoordinate2D //  ex> 서울시 용산구 효창동 -> 서울시
    var acceptedInfo: [course]
  
//전화번호 인증은 구조체에 들어가지 않음

}

struct course {
    var courseName: String
    var courseTime: Int
    var carNumber: Int
    var date: Int
    var companionHas: Bool {
        didSet {
            if companionHas == true  {
                var companion: Int
            }
        }
   }
  var guaridanHas: Bool {
   didSet {
         if guaridanHas == true {
                var guardianNumber: String
        }
    }
   }
}
//기사님 mode
struct accecptedUser {
    var users: [user]
    var locationDriver: CLLocationCoordinate2D // 기사님 현 위치
}
