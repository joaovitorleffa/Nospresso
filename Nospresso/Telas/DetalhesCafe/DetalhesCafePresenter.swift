//
//  DetalhesCafePresenter.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import Foundation

protocol DetalhesCafePresenterProtocolo {
    func telaCarregou()
    func adicionouASacola()
    func favoritou()
}

// Presenter: responsável pela lógica
class DetalhesCafePresenter {
    let api: APIProtocolo
    let cafe: Cafe
    var favoritos: FavoritosProtocolo
    weak var tela: DetalhesCafeViewProtocolo?
    
    init(api: APIProtocolo, cafe: Cafe, favoritos: FavoritosProtocolo = Favoritos.instancia, tela: DetalhesCafeViewProtocolo) {
        self.api = api
        self.cafe = cafe
        self.favoritos = favoritos
        self.tela = tela
    }
}

extension DetalhesCafePresenter: DetalhesCafePresenterProtocolo {
    func telaCarregou() {
        tela?.atualizarFavorito(valor: favoritos.estaFavoritado(cafe: cafe))
        
        api.requisitar(
            endpoint: .cafes(id: cafe.id),
            sucesso: { [weak self] (cafe: Cafe) in
                self?.tela?.recebeu(cafe: cafe)
            },
            falha: { [weak self] erro in
                self?.tela?.recebeu(erro: erro)
            }
        )
    }
    
    func adicionouASacola() {
        
    }
    
    func favoritou() {
        if favoritos.estaFavoritado(cafe: cafe) {
            favoritos.remover(cafe: cafe)
            tela?.atualizarFavorito(valor: false)
        } else {
            favoritos.adicionar(cafe: cafe)
            tela?.atualizarFavorito(valor: true)
        }
    }
    
    
}
