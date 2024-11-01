//
//  FloatingAlert.swift
//  Newletters
//
//  Created by Jorge Alfredo Cruz Acuña on 31/10/24.
//

import Foundation
import UIKit
class FloatingAlertView: UIView {
    
    private let messageLabel = UILabel()
    private static var isShowing = false
    
    init(message: String) {
        super.init(frame: .zero)
        setupView()
        setupMessageLabel(message: message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = UIColor.black
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupMessageLabel(message: String) {
        messageLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        
        self.addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            messageLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func show(in view: UIView) {
        guard !FloatingAlertView.isShowing else { return }
        FloatingAlertView.isShowing = true
        
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        self.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 1.0, animations: {
            self.alpha = 1
            self.transform = CGAffineTransform(translationX: 0, y: 140)
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.hide()
            }
        }
    }
    
    private func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = .identity
        }) { _ in
            self.removeFromSuperview()
            FloatingAlertView.isShowing = false
        }
    }
}
