//
//  AcessoriosViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation
@testable import Nospresso

class AcessoriosViewMock {
    var acessoriosRecebidos: [AcessorioCategoria]?
    var erroRecebido: ErroRequisicao?
}

extension AcessoriosViewMock: AcessoriosViewProtocolo {
    func recebeu(acessorios: [AcessorioCategoria]) {
        acessoriosRecebidos = acessorios
    }
    
    func recebeu(erro: ErroRequisicao) {
        erroRecebido = erro
    }
}
