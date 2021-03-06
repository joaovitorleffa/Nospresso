//
//  AcessoriosViewController.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

class AcessoriosViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var erroView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var acessorios: [AcessorioCategoria] = []
    lazy var api = API()
    lazy var presenter: AcessoriosPresenterProtocolo = AcessoriosPresenter(api: api, tela: self)
    
    var estado: Estado = .carregando {
        didSet {
            tableView.isHidden = estado == .carregando || estado == .erro
            erroView.isHidden = estado == .carregando || estado == .dadosProntos
            activityIndicator.isHidden = estado == .dadosProntos || estado == .erro
        }
    }
    
    override func viewDidLoad() {
        presenter = AcessoriosPresenter(api: api, tela: self)
        configurarTabela()
        presenter.telaCarregou()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurarBarraDeNavegacao()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configurarTabela() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configurarBarraDeNavegacao() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .acessorios
        navigationController?.navigationBar.tintColor = .label
    }
}

extension AcessoriosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secao = acessorios[section]
        
        let cabecalho = UINib(nibName: "CabecalhoView", bundle: .main)
            .instantiate(withOwner: nil, options: nil).first as? CabecalhoView
        
        cabecalho?.configurar(texto: secao.categoria)
        
        return cabecalho
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Produtos", bundle: .main)
        let item = acessorios[indexPath.section].itens[indexPath.row]
        let produto = Produto(nome: item.nome, tipo: .acessorios, preco: item.preco, imagem: item.imagem, descricao: item.descricao)
        
        guard let controlador = storyboard
                .instantiateViewController(withIdentifier: DetalhesProdutoViewController.identificador)
                    as? DetalhesProdutoViewController else { return }
        
        controlador.produto = produto
        
        present(controlador, animated: true)
    }
}

extension AcessoriosViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        acessorios.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        acessorios[section].itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: AcessorioTableViewCell.indetificador, for: indexPath)
        
        if let celulaDeAcessorio = celula as? AcessorioTableViewCell {
            celulaDeAcessorio.delegate = self
            celulaDeAcessorio.configurar(com: acessorios[indexPath.section].itens[indexPath.row])
        }
        
        return celula
    }
}

extension AcessoriosViewController: AcessoriosViewProtocolo {    
    func recebeu(acessorios: [AcessorioCategoria]) {
        self.acessorios = acessorios
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.estado = .dadosProntos
        }
    }
    
    func recebeu(erro: ErroRequisicao) {
        estado = .erro
    }
}

extension AcessoriosViewController: AcessorioTableViewCellDelegateProtocol {
    func favoritar(acessorio: Acessorio) -> Bool {
        presenter.favoritar(acessorio: acessorio)
    }
    
    func estaFavoritado(acessorio: Acessorio) -> Bool {
        presenter.estaFavoritado(acessorio: acessorio)
    }
    
    func quantidadeNaSacola(acessorio: Acessorio) -> Int {
        presenter.quantidadeNaSacola(acessorio: acessorio)
    }
    
    func adicionarASacola(acessorio: Acessorio) {
        presenter.adicionarASacola(acessorio: acessorio)
    }
}
