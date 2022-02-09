//
//  CafesPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol CafesPresenterProtocolo {
    func telaCarregou()
}

class CafesPresenter {
    private var api: APIProtocolo
    private weak var tela: CafesViewProtocolo?
    
    init(api: APIProtocolo, tela: CafesViewProtocolo) {
        self.api = api
        self.tela = tela
    }
}

extension CafesPresenter: CafesPresenterProtocolo {
    func telaCarregou() {
        api.requisitar(endpoint: .capsulas) { [weak self] (capsulas: [Capsulas]) in
            self?.tela?.recebeu(capsulas: capsulas)
        } falha: { [weak self] erro in
            self?.tela?.recebeu(erro: erro)
        }
    }
}
