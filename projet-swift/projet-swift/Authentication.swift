//
//  Authentication.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import Foundation

final class Auth{
    var hasError = false
    
    func loginUser(email: String, password: String) -> [String: String]  {

        guard !email.isEmpty && !password.isEmpty else {
            print("Invalid text field")
            let dic:[String:String] = ["message" : "Champs vide"]
            return dic
        }

        var request = URLRequest(url: URL(string: "http://localhost:8888/endpoints/auth/login.php")!)
        let parameters = "email=" + email + "&password=" + password

        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                dump(json)
            } catch {
                print("error")
            }
        })
        task.resume()
        let dic:[String:String] = ["message" : "Login ou Mot de passe invalid"]
        return dic

        /*URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self?.hasError = true
                } else if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        dump(json)
                        if(json["data"] != nil){
                            let user = try JSONDecoder().decode(User.self, from: json["data"] as! Data)
                            print(user.prenom)
                        }
                        print("No data found")
                        
                    } catch {
                        print("Unable to Decode Response : \(error)")
                    }
                }
            }
        }.resume()*/
        
    }
}

