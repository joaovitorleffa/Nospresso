//
//  FavoritosPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol FavoritosPresenterProtocolo {
    func telaCarregou()
}

class FavoritosPresenter {
    private var favoritos: FavoritosProtocolo
    private weak var tela: FavoritosViewProtocolo?
    
    init(tela: FavoritosViewProtocolo, favoritos: FavoritosProtocolo = Favoritos.instancia) {
        self.tela = tela
        self.favoritos = favoritos
    }
}

extension FavoritosPresenter: FavoritosPresenterProtocolo {
    func telaCarregou() {
        tela?.recebeu(favoritos: favoritos.buscar())
    }
}
