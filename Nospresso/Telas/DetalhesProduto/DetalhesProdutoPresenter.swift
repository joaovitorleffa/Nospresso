//
//  DetalhesProdutoPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol DetalhesProdutoPresenterProtocolo {
    func favoritar(_ produto: Produto)
    func adicionarASacola(_ produto: Produto)
}

class DetalhesProdutoPresenter {
    private var sacola: SacolaProtocolo
//    private var acessorio: Acessorio
    private var favoritos: FavoritosProtocolo
    private weak var tela: DetalhesProdutoViewProtocolo?
    
    init(
        sacola: SacolaProtocolo = Sacola.instancia,
        tela: DetalhesProdutoViewProtocolo,
        favoritos: FavoritosProtocolo = Favoritos.instancia
    ) {
//        self.acessorio = acessorio
        self.sacola = sacola
        self.tela = tela
        self.favoritos = favoritos
    }
}

extension DetalhesProdutoPresenter: DetalhesProdutoPresenterProtocolo {
    func favoritar(_ produto: Produto) {
//        let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
        
        if favoritos.estaFavoritado(favorito: produto) {
            favoritos.remover(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: false)
        } else {
            favoritos.adicionar(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: true)
        }
    }
    
    func adicionarASacola(_ produto: Produto) {
//        let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
        sacola.adicionar(produto: produto)
        tela?.produtoAdicionadoASacola(produto: produto)
    }
}
