//
//  Badge.swift
//  Nospresso
//
//  Created by joaovitor on 25/02/22.
//

import UIKit

protocol Badgeable {}

extension UIView: Badgeable {
    func addBage() {
        translatesAutoresizingMaskIntoConstraints = false
    
        let badge = UIButton()
        
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
        badge.layer.cornerRadius = Constants.diameter / 2
        badge.setTitleColor(.badgeTitle, for: .normal)
        badge.backgroundColor = .badge
        badge.setTitle("0", for: .normal)
        badge.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
        
        addSubview(badge)
        
        NSLayoutConstraint.activate([
            badge.heightAnchor.constraint(equalToConstant: Constants.diameter),
            badge.widthAnchor.constraint(equalToConstant: Constants.diameter),
            badge.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            badge.bottomAnchor.constraint(equalTo: topAnchor, constant: 30)
        ])
        
    }
    
    private struct Constants {
        static let diameter: CGFloat = 22
    }
}
