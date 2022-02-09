//
//  DetalhesAcessorioViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation
@testable import Nospresso

class DetalhesAcessorioViewMock {
    var acessorio: Acessorio
    var acessorioEstaFavoriado: Bool?
    var produtoAdicionadoASacola: Produto?
    
    init(acessorio: Acessorio) {
        self.acessorio = acessorio
    }
}

extension DetalhesAcessorioViewMock: DetalhesAcessorioViewProtocolo {
    func atualizarFavorito(estaFavoritado: Bool) {
        acessorioEstaFavoriado = estaFavoritado
    }
    
    func produtoAdicionadoASacola(produto: Produto) {
       produtoAdicionadoASacola = produto
    }
}
