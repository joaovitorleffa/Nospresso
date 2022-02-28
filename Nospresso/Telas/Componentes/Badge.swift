//
//  Badge.swift
//  Nospresso
//
//  Created by joaovitor on 25/02/22.
//

import UIKit

//protocol Badgeable {}
//
//extension UIView: Badgeable {
//    func addBage(_ quantidade: Int = 0) {
//        translatesAutoresizingMaskIntoConstraints = false
//
//        let badge = UIButton()
//
//        badge.translatesAutoresizingMaskIntoConstraints = false
//        badge.contentEdgeInsets = .init(top: 0, left: 4, bottom: 0, right: 4)
//        badge.layer.cornerRadius = Constants.diameter / 2
//        badge.setTitleColor(.badgeTitle, for: .normal)
//        badge.backgroundColor = .badge
//        badge.setTitle("\(quantidade)", for: .normal)
//        badge.titleLabel?.font = UIFont(name: "OpenSans-Bold", size: 16)
//
//        addSubview(badge)
//
//        NSLayoutConstraint.activate([
//            badge.heightAnchor.constraint(equalToConstant: Constants.diameter),
//            badge.widthAnchor.constraint(equalToConstant: Constants.diameter),
//            badge.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            badge.bottomAnchor.constraint(equalTo: topAnchor, constant: 30)
//        ])
//
//    }
//
//    private struct Constants {
//        static let diameter: CGFloat = 22
//    }
//}

fileprivate class BadgeView: UIView {
    func setBackgroundColor(_ backgroundColor: UIColor?) {
        super.backgroundColor = backgroundColor
    }
}

class BadgeHub: NSObject {
    private var redCircle: BadgeView!
//    private var baseFrame = CGRect.zero
//    private var initialFrame = CGRect.zero
//
    var hubView: UIView?
    
    var count: Int = 0 {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
        }
    }
    
    private var countLabel: UILabel? {
        didSet {
            countLabel?.text = "\(count)"
            checkZero()
        }
    }
    
    private struct Constants {
        static let notificHubDefaultDiameter: CGFloat = 30
    }
    
    public init(view: UIView) {
        super.init()
        setView(view)
    }
    
    public func setCount(_ newCount: Int) {
        self.count = newCount
        countLabel?.text = "\(count)"
        checkZero()
    }
    
    public func checkZero() {
        if count <= 0 {
            redCircle.isHidden = true
            countLabel?.isHidden = true
        } else {
            redCircle.isHidden = false
            countLabel?.isHidden = false
        }
    }
    
    public func setView(_ view: UIView?) {
        let frame: CGRect? = view?.frame
        
        redCircle = BadgeView()
        redCircle.isUserInteractionEnabled = false
        redCircle.backgroundColor = .red
        
        countLabel = UILabel(frame: redCircle.frame)
        countLabel?.isUserInteractionEnabled = false
        countLabel?.textAlignment = .center
        countLabel?.textColor = .white
        countLabel?.backgroundColor = .clear
        
        let atFrame = CGRect(x: (frame?.size.width ?? 0.0) - ((Constants.notificHubDefaultDiameter) * 2 / 3),
                             y: (-Constants.notificHubDefaultDiameter) / 3,
                             width: CGFloat(Constants.notificHubDefaultDiameter),
                             height: CGFloat(Constants.notificHubDefaultDiameter))
        setCircleAtFrame(atFrame)
        
        view?.addSubview(redCircle)
        view?.addSubview(countLabel!)
        view?.bringSubviewToFront(redCircle)
        view?.bringSubviewToFront(countLabel!)
        hubView = view
        checkZero()
    }
    
    public func setCircleAtFrame(_ frame: CGRect) {
        redCircle.frame = frame
        
        countLabel?.frame = redCircle.frame
        redCircle.layer.cornerRadius = frame.size.height / 2
        countLabel?.font = UIFont.systemFont(ofSize: frame.size.width / 2)
    }
    
    public func setCircleColor(_ circleColor: UIColor?, label labelColor: UIColor?) {
        redCircle.backgroundColor = circleColor
        if let labelColor = labelColor {
            countLabel?.textColor = labelColor
        }
    }
}
