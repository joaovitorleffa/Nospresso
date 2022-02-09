//
//  Favoritos.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import Foundation

protocol FavoritosProtocolo {
    func estaFavoritado(favorito: Produto) -> Bool
    func adicionar(favorito: Produto)
    func remover(favorito: Produto)
    func limpar()
    func buscar() -> [Produto]
}

class Favoritos {
    static let instancia = Favoritos()
    
    private let padroesDeUsuario = UserDefaults.standard
    private let chave = "@nospresso:favoritos"
    
    private init() {} // não permite a inicialização de uma instância em outros lugares
    
    var favoritos: Set<Produto> = [] {
        didSet {
            atualizarBanco()
        }
    }
    
    private func atualizarBanco() {
        guard let dadosJson = try? JSONEncoder().encode(favoritos) else { return }
        
        padroesDeUsuario.setValue(dadosJson, forKey: chave)
    }
    
    private func buscarDoArmazenamentoLocal() {
        guard let dados = padroesDeUsuario.data(forKey: chave),
              let favoritados = try? JSONDecoder().decode([Produto].self, from: dados) else { return }
    
        favoritos = Set(favoritados)
    }
}

extension Favoritos: FavoritosProtocolo {
    func estaFavoritado(favorito: Produto) -> Bool {
        favoritos.contains(favorito)
    }
    
    func adicionar(favorito: Produto) {
        favoritos.insert(favorito)
    }
    
    func remover(favorito: Produto) {
        favoritos.remove(favorito)
    }
    
    func limpar() {
        favoritos.removeAll()
    }
    
    func buscar() -> [Produto] {
        return Array(favoritos)
    }
}
