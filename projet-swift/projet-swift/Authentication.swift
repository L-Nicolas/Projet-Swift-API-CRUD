//
//  Authentication.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import Foundation

final class Auth{
    var hasError = false
    
    func loginUser(email: String, password: String) async -> [String: String] {
        
        var dic:[String:String] = [:]

        guard !email.isEmpty && !password.isEmpty else {
            print("Invalid text field")
            dic["message"] = "Champs vide" as String
            return dic
        }

        var request = URLRequest(url: URL(string: "http://localhost:8888/backend-PHP/endpoints/auth/login.php")!)
        let parameters = "email=" + email + "&password=" + password

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        //Ancienne version non asynchrone
        /*
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                dic = json
            } catch {
                print("error")
            }
        })
        task.resume()*/
        
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, Any>
            if let token = json["token"] as? String{
                dic = ["token" : token]
            }
            return dic
        }
        catch {
            return dic
        }
    }
}

