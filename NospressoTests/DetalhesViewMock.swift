//
//  DetalhesViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class DetalhesViewMock {
    var cafeRecebido: Cafe?
    var erroRecebido: ErroRequisicao?
    var foiAtualizado: Bool?
}

extension DetalhesViewMock: DetalhesCafeViewProtocolo {
    func recebeu(cafe: Cafe) {
        cafeRecebido = cafe
    }
    
    func recebeu(erro: ErroRequisicao) {
         erroRecebido = erro
    }
    
    func atualizarFavorito(valor: Bool) {
        foiAtualizado = valor
    }
}
