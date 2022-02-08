//
//  Cafe.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

struct Cafe: Codable, Hashable {
    let id: Int
    let nome: String
    let preco: Double
    let descricao: String
    let imagem: String
    let medidas: [MedidaCafe]
    let intensidade: Int?
    let origem: String?
    let torrefacao: String?
    let perfilAromatico: String?
    
    enum MedidaCafe: String, Codable {
        case ristretto
        case espresso
        case lungo
    }
    
    // adaptando uma propriedade com nome diferente
    enum CodingKeys: String, CodingKey {
        case id, nome, descricao, imagem, medidas, origem, torrefacao, perfilAromatico, intensidade
        case preco = "precoUnitario"
    }
}
