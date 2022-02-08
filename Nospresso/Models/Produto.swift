//
//  Sacola.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

struct Produto: Codable, Hashable {
    let nome: String
    let tipo: TipoProduto
    let preco: Double
    let imagem: String
}

enum TipoProduto: Codable, Hashable {
    case cafes
    case maquinas
    case acessorios
}
