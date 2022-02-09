//
//  FavoritosMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class FavoritosMock {
    var favoritos: Set<Produto> = []
}

extension FavoritosMock: FavoritosProtocolo {
    func estaFavoritado(favorito: Produto) -> Bool {
        favoritos.contains(favorito)
    }
    
    func adicionar(favorito: Produto) {
        favoritos.insert(favorito)
    }
    
    func remover(favorito: Produto) {
        favoritos.remove(favorito)
    }
    
    func limpar() {
        favoritos.removeAll()
    }
    
    func buscar() -> [Produto] {
        return Array(favoritos)
    }
}
