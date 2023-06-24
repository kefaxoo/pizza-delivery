//
//  PromoNavigationView.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit

class PromoNavigationView: UIView {

    lazy var promoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 175, height: 220)
        layout.sectionInset = UIEdgeInsets(left: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(PromoCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private lazy var menuPresenter: MenuPresenter = {
        return MenuPresenter(delegate: self)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInterface()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInterface()
    }
    
    private func setupInterface() {
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.addSubview(promoCollectionView)
    }
    
    private func setupConstraints() {
        promoCollectionView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension PromoNavigationView: MenuPresenterDelegate {
    func reloadData() {
        promoCollectionView.reloadData()
    }
}

extension PromoNavigationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuPresenter.promo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromoCollectionViewCell.id, for: indexPath)
        guard let promoCell = cell as? PromoCollectionViewCell else { return cell }
        
        promoCell.set(promo: menuPresenter.promo[indexPath.row])
        return promoCell
    }
}

extension PromoNavigationView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 220)
    }
}
