//
//  json_tset.swift
//  BobBob
//
//  Created by Hamlit Jason on 2021/04/26.
//

import UIKit
import Foundation

struct CountryModel: Codable{
    let latitudeValue : Float
    let longitudeValue : Float
    let delta : Int
    let title : String
    let subtitle : String
}

class json_test : UIViewController {
    
    func readJson(){
        print("first")
        if let path = Bundle.main.path(forResource: "Data", ofType: "json") {
            print(path)
            do {
                print("sec")
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                do {
       // get the data from JSON file with help of struct and Codable
                    let countryModel = try decoder.decode([CountryModel].self, from: data)
       // from here you can populate data in tableview
                    print(countryModel)
                }catch{
                    print(error) // shows error
                    print("Decoding failed")// local message
                }
            } catch {
                print(error) // shows error
                print("Unable to read file")// local message
            }
        }
        
    }
    


}
