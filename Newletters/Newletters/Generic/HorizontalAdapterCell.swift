//
//  HorizontalAdapterCell.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 29/10/24.
//

import Foundation
import UIKit

protocol ConfigurableCell {
    associatedtype DataType
    func configure(with item: DataType)
}

protocol HorizontalAdapterCellDelegate: AnyObject{
    func didSelect(indexPath: IndexPath)
}

class HorizontalAdapterCell<Item, Cell: UICollectionViewCell>: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where Cell: ConfigurableCell{
    
    lazy var listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let listCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return listCollectionView
    }()
    weak var delegate: HorizontalAdapterCellDelegate?
    var itemSize: CGSize = CGSize(width: 0, height: 0)
    var items: [Cell.DataType] = [] {
        didSet {
            listCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(listCollectionView)
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(Cell.self, forCellWithReuseIdentifier: String(describing: Cell.self))
        
        NSLayoutConstraint.activate([
            listCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            listCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell{
            cell.configure(with: items[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(indexPath: IndexPath(row: indexPath.row, section: tag))
    }
}
