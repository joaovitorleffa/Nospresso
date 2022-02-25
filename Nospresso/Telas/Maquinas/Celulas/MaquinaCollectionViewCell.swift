//
//  MaquinaCollectionViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 25/02/22.
//

import UIKit

protocol MaquinaCollectionViewCellDelegate: AnyObject {
    func favoritar(maquina: Maquina) -> Bool
    func estaFavoritado(maquina: Maquina) -> Bool
}

class MaquinaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var imagem: UIImageView!
    @IBOutlet weak var preco: UILabel!
    @IBOutlet weak var botaoFavoritar: UIButton!
    
    var delegate: MaquinaCollectionViewCellDelegate?
    var maquina: Maquina?
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let maquina = maquina {
            let favoritou = delegate?.favoritar(maquina: maquina)
            if let favoritou = favoritou {
                configurarFavorito(favoritado: favoritou)
            }
        }
    }
    
    func configurar(com maquina: Maquina) {
        self.maquina = maquina
        
        nome.text = maquina.nome
        imagem.carregarImagem(da: maquina.imagem)
        preco.text = maquina.preco.comoDinheiro
        
        let estaFavoritado = delegate?.estaFavoritado(maquina: maquina)
        if let estaFavoritado = estaFavoritado {
            configurarFavorito(favoritado: estaFavoritado)
        }
    }
    
    private func estadoFavoritado() {
        let imagem = UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
        botaoFavoritar.setImage(imagem, for: .normal)
    }
    
    private func estadoNaoFavoritado() {
        let imagem = UIImage(systemName: "heart")
        botaoFavoritar.setImage(imagem, for: .normal)
    }
    
    private func configurarFavorito(favoritado: Bool) {
        favoritado ? estadoFavoritado() : estadoNaoFavoritado()
    }
}

extension MaquinaCollectionViewCell {
    static let identificador: String = "maquina-celula"
}
