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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        intensidadeLabel.isHidden = false
    }
    
    func configura(com cafe: Cafe) {
        capsulaImageView.carregarImagem(da: cafe.imagem)
        nomeLabel.text = cafe.nome
        descricaoLabel.text = cafe.descricao.capitalized
        precoLabel.text = cafe.preco.comoDinheiro
        
        if let intensidade = cafe.intensidade {
            intensidadeLabel.text = "Intesindae \(intensidade)"
        } else {
            intensidadeLabel.isHidden = true
        }
    }

}
