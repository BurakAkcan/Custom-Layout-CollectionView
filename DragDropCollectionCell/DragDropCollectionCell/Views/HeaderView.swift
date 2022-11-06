//
//  HeaderView.swift
//  DragCollectionCell
//
//  Created by Burak AKCAN on 4.11.2022.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    static let identifier = String(describing: HeaderView.self)
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHeader() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    func setHeaderView(_ title: String) {
        nameLabel.text = title
    }
}
