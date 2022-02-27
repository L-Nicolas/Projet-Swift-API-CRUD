//
//  ListRapportWebService.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class ListRapportWebService {
    static func getListRapport(token: String) async -> [String: AnyObject]  {
        
        var dic:[String:AnyObject] = [:]
        dic["error"] = 1 as AnyObject

        /*guard !email.isEmpty && !password.isEmpty else {
            print("Invalid text field")
            dic["message"] = "Champs vide" as AnyObject
            return dic
        }*/

        var request = URLRequest(url: URL(string: "http://localhost:3000/api/user/rapport/list/user")!)
        let parameters = "token=" + token
        
        dump(parameters)

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            //dic["data"] = json["data"] as AnyObject
            dic["error"] = json["error"] as AnyObject
            dic["message"] = json["message"] as AnyObject
            dic["data"] = json["data"] as AnyObject
            let num: Int
            num = 0
            
            if json["error"] === num as NSNumber {
                dic["data"] = json["data"] as AnyObject
            }
            return dic
        }
        catch {
            return dic
        }
    }
}
