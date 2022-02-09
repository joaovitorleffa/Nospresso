//
//  ContandorIntensidadeStackView.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import UIKit

class ContandorIntensidadeStackView: UIStackView {
    
    private let intesidadeMaxima = 13
    private let tamanhoBolinha: CGFloat = 10
    
    // NSCoder declara a interface usada por subclasses concretas para transferir objetos e outros valores entre a memória e algum outro formato.
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        axis = .horizontal
        distribution = .fill
        spacing = 1.5
    }
    
    func configurar(com cafe: Cafe) {
        if let intesidade = cafe.intensidade {
            adicionarBolinhas(para: intesidade)
        }
    }
    
    private func adicionarBolinhas(para quantidade: Int) {
        let quantidadeDeIntensidadeVazias = intesidadeMaxima - quantidade
        
        for _ in 0..<quantidade {
            addArrangedSubview(gerarBolinha(preenchido: true))
        }
        
        for _ in 0..<quantidadeDeIntensidadeVazias {
            addArrangedSubview(gerarBolinha(preenchido: false))
        }
    
        addArrangedSubview(.init())
    }
    
    private func gerarBolinha(preenchido: Bool) -> UIView {
        let bolinhaView = UIView()

        NSLayoutConstraint.activate([
            bolinhaView.widthAnchor.constraint(equalToConstant: tamanhoBolinha),
            bolinhaView.heightAnchor.constraint(equalToConstant: tamanhoBolinha)
        ])
        
        bolinhaView.layer.cornerRadius = tamanhoBolinha / 2
        bolinhaView.layer.borderWidth = 0.4
        bolinhaView.layer.borderColor = preenchido ? UIColor.black.cgColor : UIColor.bordaIntensidadeVazia?.cgColor
        bolinhaView.backgroundColor = preenchido ? .intesidadePreenchida : .intesidadeVazia
        
        return bolinhaView
    }
}
