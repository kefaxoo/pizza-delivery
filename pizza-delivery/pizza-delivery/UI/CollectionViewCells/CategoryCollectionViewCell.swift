//
//  CategoryCollectionViewCell.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).withAlphaComponent(0.4).cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 13)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    private(set) var category: CategoryType = .pizza
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(category: CategoryType) {
        self.category = category
        titleLabel.text = category.title
        setupInterface()
        isSelected ? selectCell() : deselectCell()
    }
    
    func deselectCell() {
        mainView.backgroundColor = UIColor.clear
        mainView.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).withAlphaComponent(0.4).cgColor
        titleLabel.font = UIFont.systemFont(ofSize: 13)
    }
    
    func selectCell() {
        mainView.backgroundColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).withAlphaComponent(0.2)
        mainView.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).withAlphaComponent(0.2).cgColor
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
}

extension CategoryCollectionViewCell {
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(mainView)
        mainView.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(-8)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
