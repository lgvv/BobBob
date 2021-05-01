//
//  RestaurantData.swift
//  BobBob
//
//  Created by 박재영 on 2021/04/30.
//

import Foundation

struct RestaurantData: Codable{
    let index: Int
    let name : String
    let address : String
    let latitudeValue : Double
    let longitudeValue : Double
    let delta : Int
    let tier: String
    let cleanness: String
    let satisfaction: String
    let history: String
    let overview: String
    let curator: String
    let business_hour: String
}
