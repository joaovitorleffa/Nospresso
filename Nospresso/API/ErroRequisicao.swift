//
//  ErroRequisicao.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

enum ErroRequisicao {
    case urlInvalida(mensagem: String)
    case requisicaoFalhou(mensagem: String)
    case semDados
    case falhaNaDecodificacao(mensagem: String, dadosRecebidos: String?)
}
