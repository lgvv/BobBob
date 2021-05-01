//
//  JsonHelper.swift
//  BobBob
//
//  Created by 박재영 on 2021/04/30.
//

import UIKit
import Foundation

class JsonHelper: UIViewController {
    static var RestaurantList: [RestaurantData] = readJson()
    
    static func readJson() -> [RestaurantData] {
        print("first")
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("else")
            return []
        }
        print(path)
        do {
            print("sec")
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = try JSONDecoder().decode([RestaurantData].self, from: data)
            print(decoder)
            return decoder
        } catch {
            print(error) // shows error
            print("Unable to read file")// local message
        }
    return []
    }
    
}
