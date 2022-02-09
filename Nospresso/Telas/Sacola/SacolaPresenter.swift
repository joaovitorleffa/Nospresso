//
//  SacolaPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol SacolaPresenterProtocolo {
    func telaCarregou()
    func remover(produto: Produto)
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

extension SacolaPresenter {
    func buscarProdutos() -> [Produto] {
        return sacola?.buscar() ?? []
    }
}

extension SacolaPresenter: SacolaPresenterProtocolo {
    func telaCarregou() {
        tela?.recebeu(produtos: buscarProdutos())
    }
    
    func remover(produto: Produto) {
        sacola?.remover(produto: produto)
        tela?.recebeu(produtos: buscarProdutos())
    }
}