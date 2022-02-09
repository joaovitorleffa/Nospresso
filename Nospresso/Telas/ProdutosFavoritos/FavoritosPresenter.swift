//
//  FavoritosPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol FavoritosPresenterProtocolo {
    func telaCarregou()
    func remover(favorito: Produto)
}

class FavoritosPresenter {
    var favoritos: Favoritos
    weak var tela: FavoritosViewControllerProcotocolo?
    
    init(tela: FavoritosViewControllerProcotocolo, favoritos: Favoritos = Favoritos.instancia) {
        self.tela = tela
        self.favoritos = favoritos
    }
}

extension FavoritosPresenter: FavoritosPresenterProtocolo {
    func telaCarregou() {
        tela?.recebeu(favoritos: favoritos.buscar())
    }
    
    func remover(favorito: Produto) {
        favoritos.remover(favorito: favorito)
        tela?.recebeu(favoritos: favoritos.buscar())
    }
}
