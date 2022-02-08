//
//  UIImageView+Carregamento.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import UIKit
import Nuke

extension UIImageView {
    func carregarImagem(da url: String) {
        guard let url = URL(string: url) else { return }
    
        Nuke.loadImage(with: url,
                       options: ImageLoadingOptions(placeholder: UIImage(systemName: "photo")),
                       into: self)
    }
}

