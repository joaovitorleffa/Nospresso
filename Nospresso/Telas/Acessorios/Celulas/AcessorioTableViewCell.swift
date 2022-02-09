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
    
    func configurar(com acessorio: Acessorio) {
        acessorioImageView.carregarImagem(da: acessorio.imagem)
        nomeLabel.text = acessorio.nome
        precoLabel.text = acessorio.preco.comoDinheiro
    }
}

extension AcessorioTableViewCell {
    static var indetificador: String {
        "acessorio-celula"
    }
}
