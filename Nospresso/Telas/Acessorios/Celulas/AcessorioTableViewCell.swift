//
//  AcessorioTableViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

protocol AcessorioTableViewCellDelegateProtocol: AnyObject {
    func favoritar(acessorio: Acessorio) -> Bool
    func estaFavoritado(acessorio: Acessorio) -> Bool
    func quantidadeNaSacola(acessorio: Acessorio) -> Int
    func adicionarASacola(acessorio: Acessorio)
}

class AcessorioTableViewCell: UITableViewCell {
    var delegate: AcessorioTableViewCellDelegateProtocol?
    private var hub: BadgeHub?
    
    @IBOutlet weak var acessorioImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var favoritarButton: UIButton!
    @IBOutlet weak var sacolaButton: UIButton!
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let acessorio = acessorio {
            let favoritou = delegate?.favoritar(acessorio: acessorio)
            if let favoritou = favoritou {
                configurarFavorito(favoritado: favoritou)
            }
        }
    }
    
    @IBAction func toqueBotaoAdicionarASacola(_ sender: UIButton) {
        if let acessorio = acessorio {
            delegate?.adicionarASacola(acessorio: acessorio)
            let quantidadeNaSacola = delegate?.quantidadeNaSacola(acessorio: acessorio)
            hub!.setCount(quantidadeNaSacola!)
        }
    }
    
    private var acessorio: Acessorio?
    
    func configurar(com acessorio: Acessorio) {
        self.acessorio = acessorio
        popular(com: acessorio)
        
        hub = BadgeHub(view: sacolaButton)
        hub?.setCircleColor(.badge, label: .badgeTitle)
        
        let quantidadeNaSacola = delegate?.quantidadeNaSacola(acessorio: acessorio) ?? 0
        if quantidadeNaSacola > 0 && hub?.count == 0 {
            hub?.setCount(quantidadeNaSacola)
        }
        
        let estaFavoritado = delegate?.estaFavoritado(acessorio: acessorio)
        if let estaFavoritado = estaFavoritado {
            configurarFavorito(favoritado: estaFavoritado)
        }
    }
    
    private func popular(com acessorio: Acessorio) {
        acessorioImageView.carregarImagem(da: acessorio.imagem)
        nomeLabel.text = acessorio.nome
        precoLabel.text = acessorio.preco.comoDinheiro
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

extension AcessorioTableViewCell {
    static var indetificador: String {
        "acessorio-celula"
    }
}
