//
//  CafesView.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import Foundation

protocol CafesViewProtocolo: AnyObject {
    func recebeu(capsulas: [Capsulas])
    func recebeu(erro: ErroRequisicao)
}
