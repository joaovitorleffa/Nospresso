//
//  SacolaTableViewCell.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

class ProdutoTableViewCell: UITableViewCell {
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var produtoImageView: UIImageView!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    
    func configurar(produto: Produto) {
        produtoImageView.carregarImagem(da: produto.imagem)
        nomeLabel.text = produto.nome
        tipoLabel.text = String(describing: produto.tipo).uppercased()
        tipoLabel.textColor = .tipoProduto(tipo: produto.tipo)
        precoLabel.text = produto.preco.comoDinheiro
    }
}


extension ProdutoTableViewCell {
    static var identificador: String {
        "produto-celula"
    }
}
