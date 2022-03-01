//
//  getDataForProfil.swift
//  projet-swift
//
//  Created by Yanis on 01/03/2022.
//

import Foundation

final class ProfilData{
    var hasError = false
    var res: String = ""
    
    func getDataForProfil(token: String) async -> [String:AnyObject] {
        
        let dic:[String:AnyObject] = [:]

        var request = URLRequest(url: URL(string: "http://localhost:3000/api/user/get/"+token)!)
        //let parameters = "token=" + token
        
        //request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
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
