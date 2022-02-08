//
//  MenuProdutosViewController.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import UIKit

class MenuProdutosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // exibe novamente a barra de navegação
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
