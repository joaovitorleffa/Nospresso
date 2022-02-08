//
//  DetalhesCafeView.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import Foundation

protocol DetalhesCafeViewProtocolo: AnyObject {
    func recebeu(cafe: Cafe)
    func recebeu(erro: ErroRequisicao)
    func atualizarFavorito(valor: Bool)
}
