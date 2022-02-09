//
//  SacolaPresenter.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import XCTest
@testable import Nospresso

class SacolaPresenterTests: XCTestCase {
    let produto = Produto(nome: "Xícara", tipo: .acessorios, preco: 9.90, imagem: "whatever")

    var tela = SacolaViewMock()
    
    var sacolaMock = SacolaMock()
    var favoritosMock = FavoritosMock()
    
    lazy var presenter = SacolaPresenter(tela: tela, sacola: sacolaMock, favoritos: favoritosMock)
    
    func test_telaCarregouComSucesso() {
        sacolaMock.adicionar(produto: produto)
        
        presenter.telaCarregou()
     
        XCTAssertEqual(tela.produtosRecebidos, [produto])
    }
    
    func test_removerProdutoDaSacola() {
        sacolaMock.adicionar(produto: produto)
        
        presenter.remover(produto: produto)
        
        XCTAssertEqual(sacolaMock.buscar(), [])
    }

    func test_favoritarProduto() {
        sacolaMock.adicionar(produto: produto)
        
        presenter.favoritar(produto: produto)
        
        XCTAssertEqual(favoritosMock.buscar(), [produto])
    }
}
