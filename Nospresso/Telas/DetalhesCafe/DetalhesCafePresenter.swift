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
    var cafeParaFavoritar: Produto
    var sacola: SacolaProtocolo
    weak var tela: DetalhesCafeViewProtocolo?
    
    init(api: APIProtocolo, cafe: Cafe, favoritos: FavoritosProtocolo = Favoritos.instancia, sacola: SacolaProtocolo = Sacola.instancia, tela: DetalhesCafeViewProtocolo) {
        self.api = api
        self.cafe = cafe
        self.favoritos = favoritos
        self.cafeParaFavoritar = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem)
        self.tela = tela
        self.sacola = sacola
    }
}

extension DetalhesCafePresenter: DetalhesCafePresenterProtocolo {
    func telaCarregou() {
        tela?.atualizarFavorito(valor: favoritos.estaFavoritado(favorito: cafeParaFavoritar))
        
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
        let produto = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem)
        sacola.adicionar(produto: produto)
        tela?.cafeAdicionadoASacola(produto: produto)
    }
    
    func favoritou() {
        if favoritos.estaFavoritado(favorito: cafeParaFavoritar) {
            favoritos.remover(favorito: cafeParaFavoritar)
            tela?.atualizarFavorito(valor: false)
        } else {
            favoritos.adicionar(favorito: cafeParaFavoritar)
            tela?.atualizarFavorito(valor: true)
        }
    }
    
    
}
