//
//  AcessoriosPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol AcessoriosPresenterProtocolo {
    func telaCarregou()
    func favoritar(acessorio: Acessorio) -> Bool
    func estaFavoritado(acessorio: Acessorio) -> Bool
    func quantidadeNaSacola(acessorio: Acessorio) -> Int
    func adicionarASacola(acessorio: Acessorio)
}

class AcessoriosPresenter {
    private var api: APIProtocolo
    private var favoritos: FavoritosProtocolo
    private var sacola: SacolaProtocolo
    private weak var tela: AcessoriosViewProtocolo?
    
    init(api: APIProtocolo, tela: AcessoriosViewProtocolo, favoritos: FavoritosProtocolo = Favoritos.instancia, sacola: SacolaProtocolo = Sacola.instancia) {
        self.api = api
        self.tela = tela
        self.favoritos = favoritos
        self.sacola = sacola
    }
}

extension AcessoriosPresenter: AcessoriosPresenterProtocolo {
    func produto(de acessorio: Acessorio) -> Produto {
        Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem, descricao: acessorio.descricao)
    }
    
    func favoritar(acessorio: Acessorio) -> Bool {
        let produto = produto(de: acessorio)
        if favoritos.estaFavoritado(favorito: produto) {
            favoritos.remover(favorito: produto)
            return false
        }
        
        favoritos.adicionar(favorito: produto)
        return true
    }
    
    func estaFavoritado(acessorio: Acessorio) -> Bool {
        return favoritos.estaFavoritado(favorito: produto(de: acessorio))
    }
    
    func quantidadeNaSacola(acessorio: Acessorio) -> Int {
        sacola.quantidade(por: produto(de: acessorio))
    }
    
    func adicionarASacola(acessorio: Acessorio) {
        sacola.adicionar(produto: produto(de: acessorio))
    }
    
    func telaCarregou() {
        api.requisitar(endpoint: .acessorios) { [weak self] (acessorios: [AcessorioCategoria]) in
            self?.tela?.recebeu(acessorios: acessorios)
        } falha: { [weak self] erro in
            self?.tela?.recebeu(erro: erro)
        }
    }
}
