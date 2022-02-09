//
//  DetalhesAcessorioPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol DetalhesAcessorioPresenterProtocolo {
    func favoritar()
    func adicionarASacola()
}

class DetalhesAcessorioPresenter {
    private var sacola: SacolaProtocolo
    private var acessorio: Acessorio
    private var favoritos: FavoritosProtocolo
    private weak var tela: DetalhesAcessorioViewProtocolo?
    
    init(acessorio: Acessorio,
        sacola: SacolaProtocolo = Sacola.instancia,
        tela: DetalhesAcessorioViewProtocolo,
        favoritos: FavoritosProtocolo = Favoritos.instancia
    ) {
        self.acessorio = acessorio
        self.sacola = sacola
        self.tela = tela
        self.favoritos = favoritos
    }
}

extension DetalhesAcessorioPresenter: DetalhesAcessorioPresenterProtocolo {
    func favoritar() {
        let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
        
        if favoritos.estaFavoritado(favorito: produto) {
            favoritos.remover(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: false)
        } else {
            favoritos.adicionar(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: true)
        }
    }
    
    func adicionarASacola() {
        let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
        sacola.adicionar(produto: produto)
        tela?.produtoAdicionadoASacola(produto: produto)
    }
}
