//
//  API.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import Foundation

typealias ResultadoSucesso<T: Decodable> = (T) -> Void
typealias ResultadoFalha = (ErroRequisicao) -> Void

protocol APIProtocolo {
    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha)
}

class API: APIProtocolo {
    func requisitar<T>(endpoint: Endpoint, sucesso: @escaping ResultadoSucesso<T>, falha: @escaping ResultadoFalha) {
        let urlBase = "http://localhost:3000"
        guard var url = URL(string: urlBase) else {
            return falha(.urlInvalida(mensagem: "url inválida: \(urlBase)"))
        }
        
        url.appendPathComponent(endpoint.url)
        
        let requisicao = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requisicao) { dados, _, erro in
            guard erro == nil else {
                falha(.requisicaoFalhou(mensagem: erro!.localizedDescription))
                return
            }
            
            guard let dados = dados else {
                falha(.semDados)
                return
            }
            
            let decodificador = JSONDecoder()
            
            do {
                let dadosDecodificados = try decodificador.decode(T.self, from: dados)
                sucesso(dadosDecodificados)
            } catch {
                falha(
                    .falhaNaDecodificacao(
                        mensagem: error.localizedDescription,
                        dadosRecebidos: String(bytes: dados, encoding: .utf8)
                    )
                )
            }
            
        }.resume()
    }
}
