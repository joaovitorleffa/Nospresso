//
//  FavoritosViewController.swift
//  Nospresso
//
//  Created by joaovitor on 09/02/22.
//

import UIKit

class FavoritosViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favoritos: [Produto] = []
    var presenter: FavoritosPresenterProtocolo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarTabela()
        presenter = FavoritosPresenter(tela: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.telaCarregou()
        navigationController?.navigationBar.isHidden = true
    }

    func configurarTabela() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ProdutoTableViewCell", bundle: nil), forCellReuseIdentifier: ProdutoTableViewCell.identificador)
        configurarTabelaVazia()
    }
    
    private func configurarTabelaVazia() {
        let messageLabel = UILabel()
        messageLabel.text = "Nenhum item foi salvo"
        messageLabel.textColor = .textoCinza
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Open Sans", size: 20)
        tableView.backgroundView = messageLabel
    }
}

extension FavoritosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
}

extension FavoritosViewController: UITableViewDataSource {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favoritos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: ProdutoTableViewCell.identificador, for: indexPath)
        
        if let celulaDeFavorito = celula as? ProdutoTableViewCell {
            celulaDeFavorito.configurar(produto: favoritos[indexPath.row])
        }
        
        return celula
    }
}

extension FavoritosViewController: FavoritosViewProtocolo {
    func recebeu(favoritos: [Produto]) {
        self.favoritos = favoritos
        guard favoritos.count > 0 else { return }
        
        DispatchQueue.main.async {
            self.tableView.backgroundView = nil
            self.tableView.reloadData()
        }
    }
}
