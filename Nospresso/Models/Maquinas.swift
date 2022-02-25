//
//  Maquinas.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

struct Maquina: Decodable, Equatable {
    let id: Int
    let nome: String
    let preco: Double
    let descricao: String
    let imagem: String
}
