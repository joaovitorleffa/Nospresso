//
//  Endpoint.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

enum Endpoint {
    case sacolas
    case cafes(id: Int)
    case capsulas
    case acessorios
    case maquinas
    
    var url: String {
        switch self {
        case .cafes(let id):
            return "cafes/\(id)"
        default:
            return "\(self)"
        }
    }
}
