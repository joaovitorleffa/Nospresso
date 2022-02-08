//
//  Acessorios.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

struct AcessorioCategoria: Decodable {
    let categoria: String
    let itens: [Acessorio]
}

struct Acessorio: Decodable {
    let id: Int
    let nome: String
    let preco: Double
    let imagem: String
    let descricao: String?
}
