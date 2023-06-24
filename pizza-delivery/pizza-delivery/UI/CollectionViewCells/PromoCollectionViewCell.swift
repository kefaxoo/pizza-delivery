//
//  PromoCollectionViewCell.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit
import SDWebImage

class PromoCollectionViewCell: UICollectionViewCell {
    lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var promoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private var imageSize = CGSize(width: 0, height: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func set(promo: PromoModel) {
        imageSize = CGSize(width: promo.width, height: promo.height)
        if NetworkMonitor.shared.isNetworkAvailable() {
            ImageManager.saveImage(link: promo.imageLink, url: LibraryManager.getAbsolutePath(filename: promo.imageFilename, path: .documentDirectory))
            if let image = SDImageCache.shared.imageFromCache(forKey: promo.imageLink) {
                promoImageView.image = image
            } else {
                promoImageView.sd_setImage(with: URL(string: promo.imageLink))
            }
        } else {
            promoImageView.image = ImageManager.loadImage(url: LibraryManager.getAbsolutePath(filename: promo.imageFilename, path: .documentDirectory))
        }
        
        setupInterface()
    }
}

extension PromoCollectionViewCell {
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(mainView)
        mainView.addSubview(promoImageView)
    }
    
    private func setupConstraints() {
        mainView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(imageSize.height)
            make.width.equalTo(imageSize.width)
        }
        
        promoImageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}
