//
//  CafesPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol CafesPresenterProtocolo {
    func telaCarregou()
    func favoritar(cafe: Cafe) -> Bool
    func estaFavoritado(cafe: Cafe) -> Bool
}

class CafesPresenter {
    private var api: APIProtocolo
    private var favoritos: FavoritosProtocolo
    private weak var tela: CafesViewProtocolo?
    
    init(api: APIProtocolo, tela: CafesViewProtocolo, favoritos: FavoritosProtocolo = Favoritos.instancia) {
        self.api = api
        self.tela = tela
        self.favoritos = favoritos
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
    
    func favoritar(cafe: Cafe) -> Bool {
        let produto = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem, descricao: cafe.descricao)
        
        if (favoritos.estaFavoritado(favorito: produto)) {
            favoritos.remover(favorito: produto)
            return false
        }
        
        favoritos.adicionar(favorito: produto)
        return true
    }
    
    func estaFavoritado(cafe: Cafe) -> Bool {
        let produto = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem, descricao: cafe.descricao)
        return favoritos.estaFavoritado(favorito: produto)
    }
}
