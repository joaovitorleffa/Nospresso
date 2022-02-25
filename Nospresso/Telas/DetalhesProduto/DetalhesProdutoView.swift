//
//  DetalhesProdutoView.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol DetalhesProdutoViewProtocolo: AnyObject {
    func atualizarFavorito(estaFavoritado: Bool)
    func produtoAdicionadoASacola(produto: Produto)
}
