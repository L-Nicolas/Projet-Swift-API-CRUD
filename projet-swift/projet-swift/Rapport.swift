//
//  Rapport.swift
//  projet-swift
//
//  Created by Nicolas Lacoste on 27/02/2022.
//

import Foundation

class Rapport: CustomStringConvertible {
    var desc: String {
        return "Photo \(self.id) "
    }
    
    let id: String
    let type_probleme: String
    let description: String
    let etat: String
    let date: String
    
    init(id: String, type_probleme: String, description: String, etat: String, date: String) {
        self.id = id
        self.type_probleme = type_probleme
        self.description = description
        self.etat = etat
        self.date = date
    }
    
}
