//
//  Sacola.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol SacolaProtocolo {
    func adicionar(produto: Produto)
    func remover(produto: Produto)
    func buscar() -> [Produto]
}

class Sacola {
    static let instancia = Sacola()
    
    private let padroesDeUsuario = UserDefaults.standard
    private let chave = "@nospresso:sacola"
    
    var produtos: Set<Produto> = [] {
        didSet {
            atualizarBanco()
        }
    }
    
    private init() {}
    
    private func atualizarBanco() {
        guard let dadosJson = try? JSONEncoder().encode(produtos) else { return }
        
        padroesDeUsuario.setValue(dadosJson, forKey: chave)
    }
}

extension Sacola: SacolaProtocolo {
    func adicionar(produto: Produto) {
        produtos.insert(produto)
    }
    
    func remover(produto: Produto) {
        produtos.remove(produto)
    }
    
    func buscar() -> [Produto] {
        return Array(produtos)
    }
}


