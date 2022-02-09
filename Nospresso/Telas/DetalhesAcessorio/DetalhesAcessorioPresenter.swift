//
//  DetalhesAcessorioPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol DetalhesAcessorioPresenterProtocolo {
    func favoritar(produto: Produto)
    func adicionarASacola()
}

class DetalhesAcessorioPresenter {
    var sacola: SacolaProtocolo?
    var acessorio: Acessorio?
    var favoritos: Favoritos
    weak var tela: DetalhesAcessorioViewControllerProtocolo?
    
    init(acessorio: Acessorio,
        sacola: SacolaProtocolo = Sacola.instancia,
        tela: DetalhesAcessorioViewControllerProtocolo,
        favoritos: Favoritos = Favoritos.instancia
    ) {
        self.acessorio = acessorio
        self.sacola = sacola
        self.tela = tela
        self.favoritos = favoritos
    }
}

extension DetalhesAcessorioPresenter: DetalhesAcessorioPresenterProtocolo {
    func favoritar(produto: Produto) {
        if favoritos.estaFavoritado(favorito: produto) {
            favoritos.remover(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: false)
        } else {
            favoritos.adicionar(favorito: produto)
            tela?.atualizarFavorito(estaFavoritado: true)
        }
    }
    
    func adicionarASacola() {
        if let acessorio = acessorio {
            let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
            sacola?.adicionar(produto: produto)
            tela?.produtoAdicionadoASacola(produto: produto)
        }
    }
}
