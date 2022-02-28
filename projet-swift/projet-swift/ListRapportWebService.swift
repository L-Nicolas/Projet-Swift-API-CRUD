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
        dic["message"] = "Impossible de récupérer les rapports" as AnyObject
        
        var request = URLRequest(url: URL(string: "http://localhost:3000/api/user/rapport/liste/user")!)
        let parameters = "token=" + token
        
        dump(parameters)

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            dic["error"] = json["error"] as! NSNumber
            dic["message"] = json["message"] as AnyObject
            dic["data"] = json["data"] as AnyObject
            
            //let resultData = try JSONSerialization.jsonObject(with: json["data"])
            let listRapports = RapportFactory.rapports(from: json["data"] as! [[String : AnyObject]])
            dic["data"] = listRapports as AnyObject
            return dic
        }
        catch {
            return dic
        }
    }
}
