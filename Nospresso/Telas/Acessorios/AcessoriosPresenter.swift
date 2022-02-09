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
    private var api: APIProtocolo
    private weak var tela: AcessoriosViewProtocolo?
    
    init(api: APIProtocolo, tela: AcessoriosViewProtocolo) {
        self.api = api
        self.tela = tela
    }
}

extension AcessoriosPresenter: AcessoriosPresenterProtocolo {
    func telaCarregou() {
        api.requisitar(endpoint: .acessorios) { [weak self] (acessorios: [AcessorioCategoria]) in
            self?.tela?.recebeu(acessorios: acessorios)
        } falha: { [weak self] erro in
            self?.tela?.recebeu(erro: erro)
        }
    }
}
