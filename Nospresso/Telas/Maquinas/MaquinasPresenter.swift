//
//  MaquinasPresenter.swift
//  Nospresso
//
//  Created by joaovitor on 25/02/22.
//

import Foundation

protocol MaquinasPresenterProtocolo: AnyObject {
    func telaCarregou()
    func favoritar(maquina: Maquina) -> Bool
    func estaFavoritado(maquina: Maquina) -> Bool
}

class MaquinasPresenter {
    private var api: APIProtocolo
    private var favoritos: FavoritosProtocolo
    private weak var tela: MaquinasViewProtocolo?
    
    init(tela: MaquinasViewProtocolo, api: APIProtocolo, favoritos: FavoritosProtocolo = Favoritos.instancia) {
        self.tela = tela
        self.api = api
        self.favoritos = favoritos
    }
}

extension MaquinasPresenter: MaquinasPresenterProtocolo {
    func telaCarregou() {
        api.requisitar(endpoint: .maquinas) { [weak self] (maquinas: [Maquina]) in
            self?.tela?.recebeu(maquinas: maquinas)
        } falha: { error in
            print(error)
        }
    }
    
    func favoritar(maquina: Maquina) -> Bool {
        let produto = Produto(nome: maquina.nome, tipo: .maquinas, preco: maquina.preco, imagem: maquina.imagem, descricao: maquina.descricao)
        let estaFavoritado = favoritos.estaFavoritado(favorito: produto)
        
        if estaFavoritado == true {
            favoritos.remover(favorito: produto)
            return false
        }
        
        favoritos.adicionar(favorito: produto)
        return true
    }
    
    func estaFavoritado(maquina: Maquina) -> Bool {
        let produto = Produto(nome: maquina.nome, tipo: .maquinas, preco: maquina.preco, imagem: maquina.imagem, descricao: maquina.descricao)
        return favoritos.estaFavoritado(favorito: produto)
    }
}
