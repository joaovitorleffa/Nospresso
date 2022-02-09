//
//  AcessoriosPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol AcessoriosPresenterProtocolo {
    func telaCarregou()
}

class AcessoriosPresenter {
    var api: APIProtocolo
    var tela: AcessoriosViewControllerProtocolo
    
    init(api: APIProtocolo, tela: AcessoriosViewControllerProtocolo) {
        self.api = api
        self.tela = tela
    }
}

extension AcessoriosPresenter: AcessoriosPresenterProtocolo {
    func telaCarregou() {
        api.requisitar(endpoint: .acessorios) { [weak self] (acessorios: [AcessorioCategoria]) in
            self?.tela.recebeu(acessorios: acessorios)
        } falha: { [weak self] erro in
            self?.tela.recebeu(erro: erro)
        }
    }
}
