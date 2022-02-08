//
//  APIMock.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import Foundation
@testable import Nospresso

class APIMock: APIProtocolo {
    var sucesso: Decodable?
    var erro: ErroRequisicao?
    
    init(sucesso: Decodable) {
        self.sucesso = sucesso
    }
    
    init(erro: ErroRequisicao) {
        self.erro = erro
    }
    
    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha) where T : Decodable {
        if let erro = erro {
            falha(erro)
            return
        }
        
        if let modelo = self.sucesso as? T {
            sucesso(modelo)
        }
    }
}
