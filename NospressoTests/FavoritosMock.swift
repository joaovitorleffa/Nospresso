//
//  FavoritosMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class FavoritosMock {
    var cafes: Set<Cafe> = []
}

extension FavoritosMock: FavoritosProtocolo {
    func estaFavoritado(cafe: Cafe) -> Bool {
        cafes.contains(cafe)
    }
    
    func adicionar(cafe: Cafe) {
        cafes.insert(cafe)
    }
    
    func remover(cafe: Cafe) {
        cafes.remove(cafe)
    }
    
    func limpar() {
        cafes.removeAll()
    }
    
    func buscar() -> [Cafe] {
        return Array(cafes)
    }
}
