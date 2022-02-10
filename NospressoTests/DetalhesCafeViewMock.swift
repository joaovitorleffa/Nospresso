//
//  DetalhesViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class DetalhesCafeViewMock {
    var cafeRecebido: Cafe?
    var erroRecebido: ErroRequisicao?
    var foiAtualizado: Bool?
    var produtoAdicionadoASacola: Produto?
}

extension DetalhesCafeViewMock: DetalhesCafeViewProtocolo {
    func recebeu(cafe: Cafe) {
        cafeRecebido = cafe
    }
    
    func recebeu(erro: ErroRequisicao) {
         erroRecebido = erro
    }
    
    func atualizarFavorito(valor: Bool) {
        foiAtualizado = valor
    }
    
    func cafeAdicionadoASacola(produto: Produto) {
        produtoAdicionadoASacola = produto
    }
}
