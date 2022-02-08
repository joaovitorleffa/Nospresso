//
//  DetalhesCafeViewController.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import UIKit

class DetalhesCafeViewController: UIViewController {
    @IBOutlet weak var cafeImageView: UIImageView!
    @IBOutlet weak var intesidadeStackView: ContandorIntensidadeStackView!
    @IBOutlet weak var intensidadeLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    @IBOutlet weak var origemLabel: UILabel!
    @IBOutlet weak var torrefacaoLabel: UILabel!
    @IBOutlet weak var perfilAromaricoLabel: UILabel!
    @IBOutlet weak var nomeCafeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: DetalhesCafePresenterProtocolo?
    var estado: Estado = .carregando {
        didSet {
            switch estado {
            case .carregando:
                scrollView.isHidden = true
                activityIndicator.isHidden = false
            case .dadosProntos:
                activityIndicator.isHidden = true
                scrollView.isHidden = false
            case .erro:
                activityIndicator.isHidden = true
                scrollView.isHidden = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.telaCarregou()
    }
    
    @objc
    private func toqueBotaoFavorito() {
        presenter?.favoritou()
    }
}

extension DetalhesCafeViewController: DetalhesCafeViewProtocolo {
    func recebeu(erro: ErroRequisicao) {
        estado = .erro
    }
    
    func recebeu(cafe: Cafe) {
        DispatchQueue.main.async {
            self.estado = .dadosProntos
            
            self.cafeImageView.carregarImagem(da: cafe.imagem)
            self.intesidadeStackView?.configurar(com: cafe)
            self.origemLabel.text = cafe.origem
            self.torrefacaoLabel.text = cafe.torrefacao
            self.perfilAromaricoLabel.text = cafe.perfilAromatico
            self.nomeCafeLabel.text = cafe.nome
            self.precoLabel.text = cafe.preco.comoDinheiro
            
            if let intensidade = cafe.intensidade {
                self.intensidadeLabel.text = "Intensidade: \(intensidade)"
            }
        }
    }
    
    func atualizarFavorito(valor: Bool) {
        let imagem = valor
            ? UIImage(systemName: "heart.fill")?.withTintColor(.favoritoPreenchido ?? .red, renderingMode: .alwaysOriginal)
            : UIImage(systemName: "heart")
        
        let botaoFavorito = UIBarButtonItem(image: imagem,
                                            style: .plain,
                                            target: self,
                                            action: #selector(toqueBotaoFavorito))
    
        navigationItem.rightBarButtonItem = botaoFavorito
    }
}

extension DetalhesCafeViewController {
    static var identificador: String {
        String(describing: DetalhesCafeViewController.self)
    }
}

extension DetalhesCafeViewController {
    enum Estado {
        case carregando
        case dadosProntos
        case erro
    }
}
