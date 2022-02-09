//
//  DetalhesCafePresenterTests.swift
//  NospressoTests
//
//  Created by joaovitor on 08/02/22.
//

import XCTest
@testable import Nospresso

class DetalhesCafePresenterTests: XCTestCase {
    let cafe: Cafe = Cafe(id: 1,
                          nome: "Café com leite",
                          preco: 2.99,
                          descricao: "Café com leite",
                          imagem: "whatever",
                          medidas: [.espresso],
                          intensidade: 3,
                          origem: nil,
                          torrefacao:nil,
                          perfilAromatico: nil)
    
    let cafeParaFavoritar = Favorito(nome: "Café com leite", tipo: .cafes, preco: 2.99, imagem: "whatever")
    
    lazy var apiMock = APIMock(sucesso: cafe)
    
    var tela = DetalhesViewMock()
    
    var favoritoMock = FavoritosMock()
    
    lazy var presenter = DetalhesCafePresenter(api: apiMock, cafe: cafe, favoritos: favoritoMock, tela: tela)
    
    func test_telaCarregouComSucesso() {
        presenter.telaCarregou()
        
        XCTAssertEqual(cafe.id, tela.cafeRecebido?.id)
    }
    
    func test_carregouComFalha() {
        // com essa chamada falha porque o presenter é instanciado antes da api ser definida com mock do erro
        // presenter.telaCarregou()
        
        apiMock = .init(erro: .semDados)
        
        presenter.telaCarregou()
        XCTAssertNotNil(tela.erroRecebido)
    }

    func test_favoritou() {
        presenter.favoritou()
        
        XCTAssertTrue(favoritoMock.estaFavoritado(favorito: cafeParaFavoritar))
        XCTAssertTrue(tela.foiAtualizado == true)
    }
    
    func test_desfavoritou() {
        presenter.favoritou()
        presenter.favoritou()
        
        XCTAssertFalse(favoritoMock.estaFavoritado(favorito: cafeParaFavoritar))
        XCTAssertTrue(tela.foiAtualizado == false)
    }
}
