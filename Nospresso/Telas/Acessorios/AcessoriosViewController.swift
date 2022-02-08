//
//  AcessoriosViewController.swift
//  Nospresso
//
//  Created by joaovitor on 08/02/22.
//

import UIKit

class AcessoriosViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var acessorios: [AcessorioCategoria] = []
    lazy var api = API()
    
    override func viewDidLoad() {
        configurarTabela()
        requisitarDados()
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
        
        guard let controlador = storyboard
                .instantiateViewController(withIdentifier: DetalhesAcessorioViewController.identificador)
                    as? DetalhesAcessorioViewController else { return }
        
        let presenter = DetalhesAcessorioPresenter(acessorio: item, tela: controlador)
        
        controlador.item = item
        controlador.presenter = presenter
        
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
        let celula = tableView.dequeueReusableCell(withIdentifier: "acessorio-celula", for: indexPath)
        
        if let celulaDeAcessorio = celula as? AcessorioTableViewCell {
            celulaDeAcessorio.configurar(com: acessorios[indexPath.section].itens[indexPath.row])
        }
        
        return celula
    }
}

extension AcessoriosViewController {
    func requisitarDados() {
        api.requisitar(endpoint: .acessorios) { [weak self] (acessorios: [AcessorioCategoria]) in
            guard let self = self else { return }
            self.acessorios = acessorios
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } falha: { erro in
            print(erro)
        }
    }
}
