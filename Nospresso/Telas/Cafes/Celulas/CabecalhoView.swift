//
//  CabecalhoView.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import UIKit

class CabecalhoView: UIView {
    @IBOutlet weak var cabecalhoLabel: UILabel!
 
    func configurar(texto: String) {
        cabecalhoLabel.text = texto
    }
}
