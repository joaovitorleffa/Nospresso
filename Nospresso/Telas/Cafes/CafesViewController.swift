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
    
    lazy var api = API()
    var capsulas: [Capsulas] = []
    var estado: Estado = .carregando {
        didSet {
            switch estado {
            case .carregando:
                tableView.isHidden = true
                erroView.isHidden = true
                activityIndicator.isHidden = false
            case .dadosProntos:
                tableView.isHidden = false
                erroView.isHidden = true
                activityIndicator.isHidden = true
            case .erro:
                activityIndicator.isHidden = true
                erroView.isHidden = false
                // TODO: criar view de erro
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurarTabela()
        requisitarDados()
        // Do any additional setup after loading the view.
    }
    
    // quando a view está prestes a exibir
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // exibe novamente a barra de navegação
        configurarBarraDeNavegação()
    }
    
    // quando a view aparaceu
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configurarTabela() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configurarBarraDeNavegação() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = .cafes
        navigationController?.navigationBar.tintColor = .label
    }
}

extension CafesViewController {
    enum Estado {
        case carregando
        case dadosProntos
        case erro
    }
}

// MARK: Delegates

// extension referente por modificar UI
extension CafesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 100 }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 50 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let secao = capsulas[section]
        
        let cabecalho = UINib(nibName: "CabecalhoView", bundle: Bundle.main)
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

// extension referente por passar os dados para listagem
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
            celulaDeCafe.configura(com: capsulas[indexPath.section].cafes[indexPath.row])
        }
        
        return celula
    }
}

// extension referente a busca de dados
extension CafesViewController {
    func requisitarDados() {
        estado = .carregando
        api.requisitar(endpoint: .capsulas) { [weak self] (capsulas: [Capsulas]) in
            guard let self = self else { return }
            
            self.capsulas = capsulas
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.estado = .dadosProntos
            }
        } falha: { [weak self] erro in
            DispatchQueue.main.async {
                self?  .estado = .erro
            }
            print(erro)
        }
    }
}
