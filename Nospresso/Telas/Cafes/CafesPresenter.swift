//
//  CafesPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol CafesPresenterProtocolo {
    func telaCarregou()
    func adicionarASacola(cafe: Cafe)
    func favoritar(cafe: Cafe)
}

class CafesPresenter {
    var api: APIProtocolo
    var tela: CafesViewControllerProtocolo
    
    init(api: APIProtocolo, tela: CafesViewControllerProtocolo) {
        self.api = api
        self.tela = tela
    }
}

extension CafesPresenter: CafesPresenterProtocolo {
    func telaCarregou() {
        tela.iniciouBuscaPorCapsulas()
        
        api.requisitar(endpoint: .capsulas) { [weak self] (capsulas: [Capsulas]) in
            self?.tela.recebeu(capsulas: capsulas)
        } falha: { [weak self] erro in
            self?.tela.recebeu(erro: erro)
        }
    }
    
    func adicionarASacola(cafe: Cafe) {
        
    }
    
    func favoritar(cafe: Cafe) {
        
    }
}
