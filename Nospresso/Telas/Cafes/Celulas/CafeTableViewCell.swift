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
    func quantidadeNaSacola(cafe: Cafe) -> Int
    func adicionarASacola(cafe: Cafe)
}

class CafeTableViewCell: UITableViewCell {
    var delegate: CafeTableViewCellDelegateProtocol?
    private var hub: BadgeHub?
    
    @IBOutlet weak var capsulaImageView: UIImageView!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    @IBOutlet weak var sacolaButton: UIButton!
    
    @IBAction func toqueBotaoAdicionarASacola(_ sender: UIButton) {
        if let cafe = cafe {
            delegate?.adicionarASacola(cafe: cafe)
            let quantidadeNaSacola = delegate?.quantidadeNaSacola(cafe: cafe)
            hub!.setCount(quantidadeNaSacola!)
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
    
        hub = BadgeHub(view: sacolaButton)
        hub?.setCircleColor(.badge, label: .badgeTitle)
        
        let quantidadeNaSacola = delegate?.quantidadeNaSacola(cafe: cafe) ?? 0
        if quantidadeNaSacola > 0 && hub?.count == 0 {
            hub?.setCount(quantidadeNaSacola)
        }
        
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
