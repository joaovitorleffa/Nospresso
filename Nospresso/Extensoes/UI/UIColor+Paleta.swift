//
//  UIColor+Paleta.swift
//  Nospresso
//
//  Created by joaovitor on 04/02/22.
//

import UIKit

extension UIColor {
    static let cafes = UIColor(named: "cafes")
    static let acessorios = UIColor(named: "acessorios")
    static let maquinas = UIColor(named: "maquinas")
    static let bordaIntensidadeVazia = UIColor(named: "intensidade-vazia")
    static let intesidadeVazia = UIColor(named: "intensidade-vazia")
    static let intesidadePreenchida = UIColor(named: "intesidade-preenchida")
    static let favoritoPreenchido = UIColor(named: "favorito-preenchido")
    static let verdaoVendedor = UIColor(named: "verdao-vendedor")
    static let textoCinza = UIColor(named: "texto-cinza")
    static let badge = UIColor(named: "badge")
    static let badgeTitle = UIColor(named: "badge-title")
    
    static func tipoProduto(tipo: TipoProduto) -> UIColor? {
        switch tipo {
        case .cafes:
            return UIColor(named: "cafes")
        case .acessorios:
            return UIColor(named: "acessorios")
        case .maquinas:
            return UIColor(named: "maquinas")
        }
    }
}
