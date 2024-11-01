//
//  HomeHeaderViewCell.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation
import UIKit

class HomeHeaderViewCell: UICollectionReusableView {
    let titleLabel = UILabel()
    let iconImg = UIImageView()
    let actionButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.setTitle("View more", for: .normal)
        actionButton.setTitleColor(.blue, for: .normal)
        actionButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        iconImg.translatesAutoresizingMaskIntoConstraints = false
        iconImg.contentMode = .scaleAspectFit
        iconImg.tintColor = .black
        addSubview(titleLabel)
        addSubview(iconImg)
        addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            iconImg.heightAnchor.constraint(equalToConstant: 18),
            iconImg.widthAnchor.constraint(equalToConstant: 18),
            iconImg.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconImg.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconImg.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: iconImg.centerYAnchor),
            
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
