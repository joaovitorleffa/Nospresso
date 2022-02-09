//
//  AcessoriosPresenterTests.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import XCTest
@testable import Nospresso

class AcessoriosPresenterTests: XCTestCase {
    let acessorioCategoria = AcessorioCategoria(categoria: "Xícaras e Copos",
                                                itens: [
                                                    Acessorio(id: 1, nome: "Xícaras ORIGINS Espresso", preco: 150.0, imagem: "whatever", descricao: nil),
                                                ])
    
    lazy var apiMock = APIMock(sucesso: [acessorioCategoria])
    var tela = AcessoriosViewMock()
    var favoritosMock = FavoritosMock()
    lazy var presenter = AcessoriosPresenter(api: apiMock, tela: tela)
    
    func test_telaCarregouComSucesso() {
        presenter.telaCarregou()
        
        XCTAssertEqual(tela.acessoriosRecebidos, [acessorioCategoria])
    }
    
    func test_carregouComFalha() {
        apiMock = .init(erro: .semDados)
        
        presenter.telaCarregou()
        
        XCTAssertNotNil(tela.erroRecebido)
    }
}
