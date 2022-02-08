//
//  Capsulas.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

struct Capsulas: Decodable {
    let categoria: String
    let cafes: [Cafe]
}
