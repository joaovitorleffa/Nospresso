//
//  AcessorioTableViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

class AcessorioTableViewCell: UITableViewCell {
    @IBOutlet weak var acessorioImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let acessorio = acessorio {
            let acessorioParaFavoritar = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
            
            if (Favoritos.instancia.estaFavoritado(favorito: acessorioParaFavoritar)) {
                Favoritos.instancia.remover(favorito: acessorioParaFavoritar)
            } else {
                Favoritos.instancia.adicionar(favorito: acessorioParaFavoritar)
            }
            
            configurarFavorito(com: acessorioParaFavoritar)
        }
    }
    
    @IBAction func toqueBotaoAdicionarASacola(_ sender: UIButton) {
        if let acessorio = acessorio {
            let produto = Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem)
            Sacola.instancia.adicionar(produto: produto)
        }
    }
    
    private var acessorio: Acessorio?
    
    func configurar(com acessorio: Acessorio) {
        self.acessorio = acessorio
        popular(com: acessorio)
        configurarFavorito(com: Produto(nome: acessorio.nome, tipo: .acessorios, preco: acessorio.preco, imagem: acessorio.imagem))
    }
    
    private func popular(com acessorio: Acessorio) {
        acessorioImageView.carregarImagem(da: acessorio.imagem)
        nomeLabel.text = acessorio.nome
        precoLabel.text = acessorio.preco.comoDinheiro
    }
    
    private func configurarFavorito(com cafeParaFavoritar: Produto) {
        let imagem = Favoritos.instancia.estaFavoritado(favorito: cafeParaFavoritar)
            ? UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
            : UIImage(systemName: "heart")
            
        favoritarButton.setImage(imagem, for: .normal)
    }
}

extension AcessorioTableViewCell {
    static var indetificador: String {
        "acessorio-celula"
    }
}
