//
//  FavoritosMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class FavoritosMock {
    var favoritos: Set<Favorito> = []
}

extension FavoritosMock: FavoritosProtocolo {
    func estaFavoritado(favorito: Favorito) -> Bool {
        favoritos.contains(favorito)
    }
    
    func adicionar(favorito: Favorito) {
        favoritos.insert(favorito)
    }
    
    func remover(favorito: Favorito) {
        favoritos.remove(favorito)
    }
    
    func limpar() {
        favoritos.removeAll()
    }
    
    func buscar() -> [Favorito] {
        return Array(favoritos)
    }
}
