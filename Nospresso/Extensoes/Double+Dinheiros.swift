//
//  Double+Dinheiros.swift
//  Nospresso
//
//  Created by joaovitor on 07/02/22.
//

import Foundation

extension Double {
    var comoDinheiro: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "pt-BR")
        formatter.numberStyle = .currency
        
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
