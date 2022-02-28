//
//  DetalhesAcessorioPresenterTests.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import XCTest
@testable import Nospresso

class DetalhesAcessorioPresenterTests: XCTestCase {
    let acessorio = Acessorio(id: 1, nome: "Xícara", preco: 9.90, imagem: "whatever", descricao: nil)
    
    lazy var produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem, descricao: nil)
    
    lazy var tela = DetalhesAcessorioViewMock(acessorio: acessorio)
    var favoritosMock = FavoritosMock()
    var sacolaMock = SacolaMock()
    
    lazy var presenter = DetalhesProdutoPresenter(sacola: sacolaMock, tela: tela, favoritos: favoritosMock)
    
    func test_favoritarAcessorio() {
        presenter.favoritar(produto)
        
        XCTAssertEqual(favoritosMock.buscar(), [produto])
    }
    
    func test_removerAcessorioDosFavoritos() {
        presenter.favoritar(produto)
        
        presenter.favoritar(produto)
        
        XCTAssertEqual(favoritosMock.buscar(), [])
    }
    
    func test_adicionarAcessorioASacola() {
        presenter.adicionarASacola(produto)
        
        XCTAssertEqual(sacolaMock.buscar(), [produto])
    }
}
