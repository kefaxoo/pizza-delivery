//
//  CountryTableViewCell.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.label
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func set(country: CountryResponseModel) {
        titleLabel.text = "\(country.emoji) \(country.name)"
        setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension CountryTableViewCell {
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(chevronImageView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.trailing.bottom.equalToSuperview().offset(-10)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.height.width.equalTo(25)
        }
    }
}
