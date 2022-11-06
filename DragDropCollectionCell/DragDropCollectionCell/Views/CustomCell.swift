//
//  CustomCell.swift
//  DragCollectionCell
//
//  Created by Burak AKCAN on 3.11.2022.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = String(describing: CustomCell.self)
    
    private lazy var padding: CGFloat = 4
    private lazy var cellRadius: CGFloat = 16
    private lazy var cellBorderWidth: CGFloat = 4
    
    //MARK: - Outputs
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //MARK: - Initialize Cell
    override init(frame: CGRect) {
        super.init(frame: frame)
       configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Methods
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func configureCell() {
        self.layer.cornerRadius = cellRadius
        self.layer.borderWidth = cellBorderWidth
        self.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        addSubview(titleLabel)
        titleLabel.text = "test"
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setCell(_ item: Lesson?) {
        titleLabel.text = item?.name ?? ""
    }
}
