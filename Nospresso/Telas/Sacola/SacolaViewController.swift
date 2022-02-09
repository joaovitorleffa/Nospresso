//
//  SacolaViewController.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

protocol SacolaViewControllerProtocolo {
    func recebeu(produtos: [Produto])
}

class SacolaViewController: UIViewController {
    @IBOutlet weak var valorTotalDaCompra: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var produtos: [Produto] = []
    var presenter: SacolaPresenterProtocolo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SacolaPresenter(produtos: produtos, tela: self)
        configurarTabela()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurarBarraDeNavegacao()
        presenter?.telaCarregou()
    }
    
    private func configurarTabela() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProdutoTableViewCell", bundle: nil), forCellReuseIdentifier: ProdutoTableViewCell.identificador)
    }
    
    private func configurarBarraDeNavegacao() {
        navigationController?.navigationBar.barTintColor = .verdaoVendedor
        navigationController?.navigationBar.tintColor = .label
    }
}

extension SacolaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let acaoFavoritar = UIContextualAction(style: .normal, title: "Favoritar") { acao, view, concluirManipulacao in
            self.acaoParaOGestoFavoritar()
            concluirManipulacao(true)
        }
        
        acaoFavoritar.backgroundColor = .verdaoVendedor
        let configuracaoGesto = UISwipeActionsConfiguration(actions: [acaoFavoritar])
        
        return configuracaoGesto
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let acaoRemover = UIContextualAction(style: .normal, title: "Remover") { acao, view, concluirManipulacao in
            self.presenter?.remover(produto: self.produtos[indexPath.row])
            concluirManipulacao(true)
        }
        
        acaoRemover.backgroundColor = .favoritoPreenchido
        let configuracaoGesto = UISwipeActionsConfiguration(actions: [acaoRemover])
        
        return configuracaoGesto
    }
    
    func acaoParaOGestoFavoritar() {
        
    }
}

extension SacolaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: ProdutoTableViewCell.identificador, for: indexPath)
        
        if let celulaDeProduto = celula as? ProdutoTableViewCell {
            celulaDeProduto.configurar(produto: produtos[indexPath.row])
        }
        
        return celula
    }
}

extension SacolaViewController: SacolaViewControllerProtocolo {
    func recebeu(produtos: [Produto]) {
        self.produtos = produtos
        DispatchQueue.main.async {
            self.tableView.reloadData()
            let total = produtos.reduce(0, { $0 + $1.preco })
            self.valorTotalDaCompra.text = total.comoDinheiro
        }
    }
}
