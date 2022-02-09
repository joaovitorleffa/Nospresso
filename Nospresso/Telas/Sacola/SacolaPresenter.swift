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
    func favoritar(produto: Produto)
}

class SacolaPresenter {
    weak var tela: SacolaViewControllerProtocolo?
    var sacola: SacolaProtocolo
    var favoritos: FavoritosProtocolo
    
    init(tela: SacolaViewControllerProtocolo,
         sacola: SacolaProtocolo = Sacola.instancia,
         favoritos: FavoritosProtocolo = Favoritos.instancia
    ) {
        self.tela = tela
        self.sacola = sacola
        self.favoritos = favoritos
    }
}

extension SacolaPresenter {
    func buscarProdutos() -> [Produto] {
        return sacola.buscar()
    }
}

extension SacolaPresenter: SacolaPresenterProtocolo {
    func telaCarregou() {
        tela?.recebeu(produtos: buscarProdutos())
    }
    
    func remover(produto: Produto) {
        sacola.remover(produto: produto)
        tela?.recebeu(produtos: buscarProdutos())
    }
    
    func favoritar(produto: Produto) {
        favoritos.adicionar(favorito: produto)
    }
}
