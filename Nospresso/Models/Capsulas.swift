//
//  Capsulas.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

struct Capsulas: Decodable, Equatable {
    let categoria: String
    let cafes: [Cafe]
}
