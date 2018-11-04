//
//  GasRequests.swift
//  FuelApp
//
//  Created by Benjamin Ulrich on 11/3/18.
//  Copyright © 2018 Benjamin Ulrich. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


public class GasRequests {
    static func getStations(lat :String, long :String, radius: String) {
        let domain = "http://api.mygasfeed.com/"
        let apiKey = "3h7oza1zx1"
//        let Latitude = "37.8716"
//        let Longitude = "-122.2727"
//        let distance = "1"
        
        let Latitude = lat
        let Longitude = long
        let distance = radius

        let fuelType = "reg"
        let sortBy = "Price"
        Alamofire.request("\(domain)/stations/radius/\(Latitude)/\(Longitude)/\(distance)/\(fuelType)/\(sortBy)/\(apiKey).json?callback=?").responseString { response in
            switch response.result {
            case .success(var data):
                data = data.replacingOccurrences(of: "(", with: "")
                data = data.replacingOccurrences(of: ")", with: "")
                data = data.replacingOccurrences(of: "?", with: "")
                data = data.replacingOccurrences(of: " ", with: "")
                let d = JSON(data)
                print(d.type)
                ViewController.flag = true
                ViewController.vals = convertToDictionary(text: String(d))
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

