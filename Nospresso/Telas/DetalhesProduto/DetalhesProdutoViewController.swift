//
//  DetalhesProdutoViewController.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

class DetalhesProdutoViewController: UIViewController {
    @IBOutlet weak var acessorioImageView: UIImageView!
    @IBOutlet weak var descricaoLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var favoritoButton: UIButton!
    
    @IBAction func toqueBotaoFavoritar(_ sender: UIButton) {
        if let produto = produto {
            presenter.favoritar(produto)
        }
    }
    
    @IBAction func toqueBotaoFechar(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func adicionarASacola(_ sender: UIButton) {
        if let produto = produto {
            presenter.adicionarASacola(produto)
        }
    }
    
    var produto: Produto?
    lazy var presenter: DetalhesProdutoPresenterProtocolo = DetalhesProdutoPresenter(tela: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarDetalhes()
    }
    
    func configurarDetalhes() {
        guard let dados = produto else { return }
        
        acessorioImageView.carregarImagem(da: dados.imagem)
        nomeLabel.text = dados.nome
        precoLabel.text = dados.preco.comoDinheiro
        
        if let descricao = dados.descricao {
            descricaoLabel.text = descricao
        }
    }
}

extension DetalhesProdutoViewController: DetalhesProdutoViewProtocolo {
    func atualizarFavorito(estaFavoritado: Bool) {
        let imagem = estaFavoritado
            ? UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
            : UIImage(systemName: "heart")
        
        favoritoButton.setImage(imagem, for: .normal)
    }
    
    func produtoAdicionadoASacola(produto: Produto) {
        let alerta = UIAlertController(title: "Produto adicionado a sacola!", message: "Você adicionou o produto \"\(produto.nome)\" a sacola", preferredStyle: .alert)
        
        alerta.addAction(UIAlertAction(title: "Show", style: .default))
        
        present(alerta, animated: true)
    }
}

extension DetalhesProdutoViewController {
    static var identificador: String {
        String(describing: self)
    }
}
