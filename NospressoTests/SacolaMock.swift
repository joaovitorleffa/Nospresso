//
//  SacolaMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation
@testable import Nospresso

class SacolaMock {
    var produtos: Set<Produto> = []
}

extension SacolaMock: SacolaProtocolo {
    func quantidade(por produto: Produto) -> Int {
        produtos.filter { $0 == produto }.count
    }
    
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
