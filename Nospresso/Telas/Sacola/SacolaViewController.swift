//
//  SacolaViewController.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

protocol SacolaViewControllerProtocolo {
    func recebeu(produtos: [Produto])
    func atualizarSacola(sacola: [Any]) // TODO: Usar tipo [Sacola]
}

class SacolaViewController: UIViewController {
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
            self.acaoParaOGestoRemover()
            concluirManipulacao(true)
        }
        
        acaoRemover.backgroundColor = .favoritoPreenchido
        let configuracaoGesto = UISwipeActionsConfiguration(actions: [acaoRemover])
        
        return configuracaoGesto
    }
    
    func acaoParaOGestoFavoritar() {
        
    }
    
    func acaoParaOGestoRemover() {
        
    }
}

extension SacolaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        produtos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: "sacola-celula", for: indexPath)
        
        return celula
    }
}

extension SacolaViewController: SacolaViewControllerProtocolo {    
    func atualizarSacola(sacola: [Any]) {
        
    }
    
    func recebeu(produtos: [Produto]) {
        self.produtos = produtos
        print(produtos)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
