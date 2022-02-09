//
//  FavoritosViewMock.swift
//  NospressoTests
//
//  Created by joaovitor on 09/02/22.
//

import Foundation
@testable import Nospresso

class FavoritosViewMock {
    var favoritosRecebidos: [Produto]?
}

extension FavoritosViewMock: FavoritosViewProtocolo {
    func recebeu(favoritos: [Produto]) {
        favoritosRecebidos = favoritos
    }
}
