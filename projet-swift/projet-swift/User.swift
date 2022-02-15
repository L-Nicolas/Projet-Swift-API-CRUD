//
//  User.swift
//  projet-swift-1
//
//  Created by Nicolas Lacoste on 29/01/2022.
//

import Foundation

struct User: Decodable {
    let id: String
    let email: String
    let prenom: String
    let nom: String
    let telephone: String
    let password: String?
    let token: String
    let role: String
    let state: String
    let address: String
    let city: String
    
    // Constructor.
    init(id: String, email: String, prenom: String, nom: String, telephone: String, password: String?, token: String, role: String, state: String, address: String, city: String) {
        self.id = id
        self.email = email
        self.prenom = prenom
        self.nom = nom
        self.telephone = telephone
        self.password = password
        self.token = token
        self.role = role
        self.state = state
        self.address = address
        self.city = city
    }
}
