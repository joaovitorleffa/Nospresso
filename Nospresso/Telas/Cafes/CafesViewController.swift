//
//  CafesViewController.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import UIKit

class CafesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! 
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var erroView: UIView!
    
    var capsulas: [Capsulas] = []
    lazy var api = API()
    lazy var presenter: CafesPresenterProtocolo = CafesPresenter(api: api, tela: self)
    
    var estado: Estado = .carregando {
        didSet {
            tableView.isHidden = estado == .carregando || estado == .erro
            erroView.isHidden = estado == .carregando || estado == .dadosProntos
            activityIndicator.isHidden = estado == .dadosProntos || estado == .erro
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CafesPresenter(api: api, tela: self)
        configurarTabela()
        presenter.telaCarregou()
    }
    
    // quando a view está prestes a exibir
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // exibe novamente a barra de navegação
        configurarBarraDeNavegacao()
    }
    
    // quando a view aparaceu
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func configurarTabela() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configurarBarraDeNavegacao() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .cafes
        navigationController?.navigationBar.tintColor = .label
    }
}

// MARK: Delegates
// extension referente por modificar UI
extension CafesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secao = capsulas[section]
        
        let cabecalho = UINib(nibName: "CabecalhoView", bundle: .main)
            .instantiate(withOwner: nil, options: nil).first as? CabecalhoView
        
        cabecalho?.configurar(texto: secao.categoria)
        
        return cabecalho
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Produtos", bundle: .main)
    
        guard let controlador = storyboard
            .instantiateViewController(withIdentifier: DetalhesCafeViewController.identificador)
                as? DetalhesCafeViewController else { return }
    
        let cafe = capsulas[indexPath.section].cafes[indexPath.row]
        
        let presenter = DetalhesCafePresenter(api: api, cafe: cafe, tela: controlador)
        
        controlador.presenter = presenter
    
        navigationController?.pushViewController(controlador, animated: true)
    }
}

// extension respnsável por passar os dados para listagem
extension CafesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        capsulas.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        capsulas[section].cafes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // indexPath contém os indices das linhas e das seções
        let celula = tableView.dequeueReusableCell(withIdentifier: "cafe-celula", for: indexPath)
        
        if let celulaDeCafe = celula as? CafeTableViewCell {
            celulaDeCafe.delegate = self
            celulaDeCafe.configura(com: capsulas[indexPath.section].cafes[indexPath.row])
        }
        
        return celula
    }
}

extension CafesViewController: CafesViewProtocolo {
    func recebeu(capsulas: [Capsulas]) {
        self.capsulas = capsulas
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.estado = .dadosProntos
        }
    }
    
    func recebeu(erro: ErroRequisicao) {
        DispatchQueue.main.async {
            self.estado = .erro
        }
    }
}

extension CafesViewController: CafeTableViewCellDelegateProtocol {
    func quantidadeNaSacola(cafe: Cafe) -> Int {
        presenter.quantidadeNaSacola(cafe: cafe)
    }
    
    func adicionarASacola(cafe: Cafe) {
        presenter.adicionarASacola(cafe: cafe)
    }
    
    func favoritar(cafe: Cafe) -> Bool {
        presenter.favoritar(cafe: cafe)
    }
    
    func estaFavoritado(cafe: Cafe) -> Bool {
        presenter.estaFavoritado(cafe: cafe)
    }
}
