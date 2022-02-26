//
//  createRapport.swift
//  projet-swift
//
//  Created by Yanis on 26/02/2022.
//

import Foundation

final class createRapport{
    var hasError = false
    
    func myCreateRapport(mysubject: String, usertoken: String) async -> [String: String] {
        
        var dic:[String:String] = [:]
        var token = usertoken
        guard !mysubject.isEmpty else {
            print("Invalid text field")
            dic["message"] = "Champs vide" as String
            return dic
        }

        var request = URLRequest(url: URL(string: "http://localhost:8888/backend-PHP/endpoints/create/createRapport.php")!)
        let parameters = "subject=" + mysubject + "&token=" + token

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
            dump(json)
            //if let token = json["token"] as? String{
              //  dic = ["token" : token]
            //}
            return dic
        }
        catch {
            return dic
        }
    }
}
