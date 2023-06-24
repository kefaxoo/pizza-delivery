//
//  ItemTableViewCell.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {

    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 32
        stackView.alignment = .top
        return stackView
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.tintColor = UIColor(red: 0.13, green: 0.16, blue: 0.19, alpha: 1.00)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.tintColor = UIColor(red: 0.67, green: 0.67, blue: 0.68, alpha: 1.00)
        return label
    }()
    
    lazy var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var priceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.borderColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(red: 0.99, green: 0.23, blue: 0.41, alpha: 1.00)
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    private(set) var item: ItemModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        guard let item else { return }
        
        set(item: item)
    }
    
    func set(item: ItemModel) {
        self.item = item
        if NetworkMonitor.shared.isNetworkAvailable() {
            ImageManager.saveImage(link: item.imageLink, url: LibraryManager.getAbsolutePath(filename: item.imageFilename, path: .documentDirectory))
            if let image = SDImageCache.shared.imageFromCache(forKey: item.imageLink) {
                itemImageView.image = image
            } else {
                itemImageView.sd_setImage(with: URL(string: item.imageLink))
            }
        } else {
            itemImageView.image = ImageManager.loadImage(url: LibraryManager.getAbsolutePath(filename: item.imageFilename, path: .documentDirectory))
        }
        
        titleLabel.text = item.name
        descriptionLabel.text = item.description
        priceLabel.text = "\(item.beginPrice) 💵"
        setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension ItemTableViewCell {
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(itemImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(descriptionLabel)
        infoStackView.addArrangedSubview(priceStackView)
        priceStackView.addArrangedSubview(spacerView)
        priceStackView.addArrangedSubview(priceView)
        priceView.addSubview(priceLabel)
    }
    
    private func setupConstraints() {
        mainStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        itemImageView.snp.makeConstraints { make in
            make.height.width.equalTo(132)
        }
        
        priceStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        spacerView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        priceView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(87)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
