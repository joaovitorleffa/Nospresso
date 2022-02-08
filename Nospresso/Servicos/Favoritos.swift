//
//  Favoritos.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import Foundation

protocol FavoritosProtocolo {
    func estaFavoritado(cafe: Cafe) -> Bool
    func adicionar(cafe: Cafe)
    func remover(cafe: Cafe)
    func limpar()
    func buscar() -> [Cafe]
}

class Favoritos {
    static let instancia = Favoritos()
    
    private let padroesDeUsuario = UserDefaults.standard
    private let chave = "@nospresso:favoritos"
    
    private init() {} // não permite a inicialização de uma instância em outros lugares
    
    var cafes: Set<Cafe> = [] {
        didSet {
            atualizarBanco()
        }
    }
    
    private func atualizarBanco() {
        guard let dadosJson = try? JSONEncoder().encode(cafes) else { return }
        
        padroesDeUsuario.setValue(dadosJson, forKey: chave)
    }
    
    private func buscarDoArmazenamentoLocal() {
        guard let dados = padroesDeUsuario.data(forKey: chave),
              let favoritos = try? JSONDecoder().decode([Cafe].self, from: dados) else { return }
    
        cafes = Set(favoritos)
    }
}

extension Favoritos: FavoritosProtocolo {
    func estaFavoritado(cafe: Cafe) -> Bool {
        cafes.contains(cafe)
    }
    
    func adicionar(cafe: Cafe) {
        cafes.insert(cafe)
    }
    
    func remover(cafe: Cafe) {
        cafes.remove(cafe)
    }
    
    func limpar() {
        cafes.removeAll()
    }
    
    func buscar() -> [Cafe] {
        return Array(cafes)
    }
}
