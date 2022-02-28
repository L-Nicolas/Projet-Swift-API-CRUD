//
//  Authentication.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import Foundation

final class Auth{
    var hasError = false
    
    func loginUser(email: String, password: String) async -> [String: AnyObject] {
        let dic:[String:AnyObject] = [:]

        var request = URLRequest(url: URL(string: "http://localhost:3000/api/user/connect")!)
        let parameters = "email=" + email + "&password=" + password
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            return json
        }
        catch {
            return dic
        }
    }
}

