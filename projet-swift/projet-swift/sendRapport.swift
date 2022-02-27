//
//  sendRapport.swift
//  projet-swift
//
//  Created by Yanis on 27/02/2022.
//

import Foundation

var hasError = false

final class sendReport{
    func sendnewReport(myProblem: String, iDescription: String, token: String) async -> [String: AnyObject] {
    
        var dic:[String:AnyObject] = [:]



        var request = URLRequest(url: URL(string: "http://localhost:3000/api/user/rapport/create/")!)
        var parameters = "token=" + token + "&type_probleme=" + myProblem + "&description=" + iDescription
    
        
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = parameters.data(using: String.Encoding.utf8)
    
    
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let json = try JSONSerialization.jsonObject(with: data) as! Dictionary<String, AnyObject>
            dic["data"] = json as AnyObject
            return dic
        }
        catch {
            print("error")
            return dic
        }
    }
}

