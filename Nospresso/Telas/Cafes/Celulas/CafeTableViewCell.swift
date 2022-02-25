//
//  CafeTableViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import UIKit

protocol CafeTableViewCellDelegateProtocol: AnyObject {
    func favoritar(cafe: Cafe) -> Bool
    func estaFavoritado(cafe: Cafe) -> Bool
}

class CafeTableViewCell: UITableViewCell {
    var delegate: CafeTableViewCellDelegateProtocol?
    
    @IBOutlet weak var capsulaImageView: UIImageView!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    
    @IBAction func toqueBotaoAdicionarASacola(_ sender: UIButton) {
        if let cafe = cafe {
            let produto = Produto(nome: cafe.nome, tipo: .cafes, preco: cafe.preco, imagem: cafe.imagem, descricao: cafe.descricao)
            Sacola.instancia.adicionar(produto: produto)
        }
    }
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let cafe = cafe {
            let favoritou = delegate?.favoritar(cafe: cafe)
            if let favoritou = favoritou {
                configurarFavorito(favoritado: favoritou)
            }
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
        
        let estaFavoritado = delegate?.estaFavoritado(cafe: cafe)
        if let estaFavoritado = estaFavoritado {
            configurarFavorito(favoritado: estaFavoritado)
        }
    }
    
    private func estadoFavoritado() {
        let imagem = UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
        favoritarButton.setImage(imagem, for: .normal)
    }
    
    private func estadoNaoFavoritado() {
        let imagem = UIImage(systemName: "heart")
        favoritarButton.setImage(imagem, for: .normal)
    }
    
    private func configurarFavorito(favoritado: Bool) {
        favoritado ? estadoFavoritado() : estadoNaoFavoritado()
    }
}
