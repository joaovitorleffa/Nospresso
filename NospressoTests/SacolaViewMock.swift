//
//  SacolaViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation
@testable import Nospresso

class SacolaViewMock {
    var produtosRecebidos: [Produto]?
}

extension SacolaViewMock: SacolaViewControllerProtocolo {
    func recebeu(produtos: [Produto]) {
        produtosRecebidos = produtos
    }
}
