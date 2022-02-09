//
//  FavoritosPresenterTests.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import XCTest
@testable import Nospresso

class FavoritosPresenterTests: XCTestCase {
    let produto = Produto(nome: "Xícara", tipo: .acessorios, preco: 9.90, imagem: "whatever")
    
    var tela = FavoritosViewMock()
    var favoritosMock = FavoritosMock()
    
    lazy var presenter = FavoritosPresenter(tela: tela, favoritos: favoritosMock)

    func test_telaCarregouComSucesso_naoDeveRetornarNenhumProduto() {
        presenter.telaCarregou()
        
        XCTAssertEqual(tela.favoritosRecebidos, [])
    }
    
    func test_telaCarregouComSucesso_deveRetornarProdutoFavoritado() {
        favoritosMock.adicionar(favorito: produto)
        
        presenter.telaCarregou()
        
        XCTAssertEqual(tela.favoritosRecebidos, [produto])
    }
}
