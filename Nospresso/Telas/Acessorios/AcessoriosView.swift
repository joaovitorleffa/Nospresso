//
//  AcessoriosView.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol AcessoriosViewProtocolo: AnyObject {
    func recebeu(acessorios: [AcessorioCategoria])
    func recebeu(erro: ErroRequisicao)
}
