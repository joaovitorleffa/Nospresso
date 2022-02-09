//
//  CafesViewPresenterTests.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import XCTest
@testable import Nospresso

class CafesViewPresenterTests: XCTestCase {
    let capsulas = Capsulas(categoria: "Master Origin",
                         cafes: [
                            Cafe(id: 1,
                                 nome: "Café com leite",
                                 preco: 2.99,
                                 descricao: "Café com leite",
                                 imagem: "whatever",
                                 medidas: [.espresso],
                                 intensidade: 3,
                                 origem: nil,
                                 torrefacao:nil,
                                 perfilAromatico: nil)
                         ])
    
    var tela = CafesViewMock()
    lazy var apiMock = APIMock(sucesso: [capsulas])
    lazy var presenter = CafesPresenter(api: apiMock, tela: tela)
    
    func test_telaCarregouComSucesso() {
        presenter.telaCarregou()
        
        XCTAssertEqual(tela.cafesRecebidos, [capsulas])
    }
    
    func test_telaCarregouComFalha() {
        apiMock = .init(erro: .semDados)
        
        presenter.telaCarregou()
        
        XCTAssertNotNil(tela.erroRecebido)
    }
}
