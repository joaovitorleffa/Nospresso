//
//  MaquinasViewController.swift
//  Nospresso
//
//  Created by joaovitor on 25/02/22.
//

import UIKit

class MaquinasViewController: UIViewController {
    @IBOutlet weak var colecao: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var maquinas: [Maquina] = []
    lazy var api = API()
    lazy var presenter: MaquinasPresenterProtocolo = MaquinasPresenter(tela: self, api: api)
    
    var estado: Estado = .carregando {
        didSet {
            colecao.isHidden = estado == .carregando
            activityIndicator.isHidden = estado == .dadosProntos
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        colecao.delegate = self
        colecao.dataSource = self
        colecao.contentInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        presenter.telaCarregou()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurarBarraDenavegacao()
    }
    

    func configurarBarraDenavegacao() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .maquinas
        navigationController?.navigationBar.tintColor = .label
    }

}


extension MaquinasViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (colecao.frame.width - (colecao.contentInset.left + colecao.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize + 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Produtos", bundle: .main)
        let item = maquinas[indexPath.row]
        let produto = Produto(nome: item.nome, tipo: .maquinas, preco: item.preco, imagem: item.imagem, descricao: item.descricao)
        
        guard let controlador = storyboard.instantiateViewController(withIdentifier: DetalhesProdutoViewController.identificador) as? DetalhesProdutoViewController else { return }
        
        controlador.produto = produto
        present(controlador, animated: true)
    }
}

extension MaquinasViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        maquinas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let celula = collectionView.dequeueReusableCell(withReuseIdentifier: MaquinaCollectionViewCell.identificador, for: indexPath)
        
        if let celulaDeMaquina = celula as? MaquinaCollectionViewCell {
            celulaDeMaquina.delegate = self
            celulaDeMaquina.configurar(com: maquinas[indexPath.row])
        }
        
        return celula
    }
}

extension MaquinasViewController: MaquinasViewProtocolo {
    func recebeu(maquinas: [Maquina]) {
        self.maquinas = maquinas
        DispatchQueue.main.async {
            self.colecao.reloadData()
            self.estado = .dadosProntos
        }
    }
}

extension MaquinasViewController: MaquinaCollectionViewCellDelegate {
    func favoritar(maquina: Maquina) -> Bool {
        presenter.favoritar(maquina: maquina)
    }
    
    func estaFavoritado(maquina: Maquina) -> Bool {
        presenter.estaFavoritado(maquina: maquina)
    }
}
