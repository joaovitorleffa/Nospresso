//
//  CafesViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

@testable import Nospresso

class CafesViewMock {
    var cafesRecebidos: [Capsulas]?
    var erroRecebido: ErroRequisicao?
}

extension CafesViewMock: CafesViewProtocolo {
    func recebeu(capsulas cafes: [Capsulas]) {
        cafesRecebidos = cafes
    }
    
    func recebeu(erro: ErroRequisicao) {
        erroRecebido = erro
    }
}
