//
//  Favorito.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

struct Favorito: Codable, Hashable {
    let nome: String
    let tipo: TipoProduto
    let preco: Double
    let imagem: String
}
