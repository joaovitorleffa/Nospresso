//
//  DetalhesAcessorioPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import Foundation

protocol DetalhesAcessorioPresenterProtocolo {
    func favoritou()
    func adicionarASacola()
}

class DetalhesAcessorioPresenter {
    var sacola: SacolaProtocolo?
    var acessorio: Acessorio?
    var tela: DetalhesAcessorioViewControllerProtocolo?
    
    init(acessorio: Acessorio, sacola: SacolaProtocolo = Sacola.instancia, tela: DetalhesAcessorioViewControllerProtocolo) {
        self.acessorio = acessorio
        self.sacola = sacola
        self.tela = tela
    }
}

extension DetalhesAcessorioPresenter: DetalhesAcessorioPresenterProtocolo {
    func favoritou() {
        // TODO: Favoritar acessório
    }
    
    func adicionarASacola() {
        if let acessorio = acessorio {
            let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
            sacola?.adicionar(produto: produto)
            tela?.produtoAdicionadoASacola()
        }
    }
}
