//
//  CafeTableViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import UIKit

class CafeTableViewCell: UITableViewCell {
    @IBOutlet weak var capsulaImageView: UIImageView!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    
    @IBAction func toqueBotaoAdicionarASacola(_ sender: UIButton) {
        if let cafe = cafe {
            let produto = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem)
            Sacola.instancia.adicionar(produto: produto)
        }
    }
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let cafe = cafe {
            let cafeParaFavoritar = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem)
            
            if (Favoritos.instancia.estaFavoritado(favorito: cafeParaFavoritar)) {
                Favoritos.instancia.remover(favorito: cafeParaFavoritar)
            } else {
                Favoritos.instancia.adicionar(favorito: cafeParaFavoritar)
            }
            
            configurarFavorito(com: cafeParaFavoritar)
        }
    }
    
    private var cafe: Cafe?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        intensidadeLabel.isHidden = false
    }
    
    func configura(com cafe: Cafe) {
        self.cafe = cafe
        popularCelula(com: cafe)
    }
    
    private func popularCelula(com cafe: Cafe) {
        capsulaImageView.carregarImagem(da: cafe.imagem)
        nomeLabel.text = cafe.nome
        descricaoLabel.text = cafe.descricao.capitalized
        precoLabel.text = cafe.preco.comoDinheiro
        
        if let intensidade = cafe.intensidade {
            intensidadeLabel.text = "Intesindade \(intensidade)"
        } else {
            intensidadeLabel.isHidden = true
        }
        
        configurarFavorito(com: Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem))
    }
    
    private func configurarFavorito(com cafeParaFavoritar: Produto) {
        let imagem = Favoritos.instancia.estaFavoritado(favorito: cafeParaFavoritar)
            ? UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
            : UIImage(systemName: "heart")
            
        favoritarButton.setImage(imagem, for: .normal)
    }
}
