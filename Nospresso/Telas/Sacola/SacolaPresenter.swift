//
//  SacolaPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol SacolaPresenterProtocolo {
    func telaCarregou()
}

class SacolaPresenter {
    var tela: SacolaViewControllerProtocolo?
    var produtos: [Produto]?
    var sacola: SacolaProtocolo?
    
    init(produtos: [Produto], tela: SacolaViewControllerProtocolo, sacola: Sacola = Sacola.instancia) {
        self.produtos = produtos
        self.tela = tela
        self.sacola = sacola
    }
}

extension SacolaPresenter: SacolaPresenterProtocolo {
    func telaCarregou() {
        let sacolaProdutos = sacola?.buscar()
        if let sacolaProdutos = sacolaProdutos {
            tela?.recebeu(produtos: sacolaProdutos)
        }
    }
}
