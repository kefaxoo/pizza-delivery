//
//  MenuViewController.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit

class MenuViewController: UIViewController {
    
    lazy var cityButton: UIButton = {
        let button = UIButton()
        button.setTitle(PizzaSettingsManager.standard.locationName, for: .normal)
        button.setTitleColor(UIColor.label, for: .normal)
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.tintColor = UIColor.label
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 8
        configuration.imagePlacement = .trailing
        button.configuration = configuration
        button.addTarget(self, action: #selector(changeLocationAction), for: .touchUpInside)
        return button
    }()
    
    lazy var promoNavigationView: PromoNavigationView = {
        return PromoNavigationView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 220))
    }()
    
    lazy var categoriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 32, height: 32)
        layout.sectionInset = UIEdgeInsets(left: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(CategoryCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(ItemTableViewCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var menuPresenter: MenuPresenter = {
        return MenuPresenter(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
    
    @objc private func changeLocationAction(_ sender: UIButton) {
        let countryVC = CountriesViewController(nibName: nil, bundle: nil).configureNavigationController(title: "Countires")
        countryVC.modalPresentationStyle = .overFullScreen
        menuPresenter.clearData()
        self.present(countryVC, animated: false)
    }
}

// MARK: -
// MARK: Setup interface methods
extension MenuViewController {
    private func setupInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationController?.navigationBar.addSubview(promoNavigationView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cityButton)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(promoNavigationView)
        self.view.addSubview(categoriesCollectionView)
        self.view.addSubview(menuTableView)
    }
    
    private func setupConstraints() {
        promoNavigationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(promoNavigationView.snp.bottom).offset(24)
            make.height.equalTo(32)
        }
        
        menuTableView.snp.makeConstraints { make in
            make.top.equalTo(categoriesCollectionView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuPresenter.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.id, for: indexPath)
        guard let itemCell = cell as? ItemTableViewCell else { return cell }
        
        itemCell.set(item: menuPresenter.items[indexPath.row])
        return itemCell
    }
}

extension MenuViewController: MenuPresenterDelegate {
    func reloadData() {
        menuTableView.reloadData()
    }
}

extension MenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuPresenter.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.id, for: indexPath)
        guard let categoryCell = cell as? CategoryCollectionViewCell else { return cell }
        
        categoryCell.set(category: menuPresenter.categories[indexPath.row])
        return categoryCell
    }
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 32, height: 32)
    }
}

extension MenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for i in 0..<menuPresenter.categories.count {
            guard let categoryCell = categoriesCollectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell else { continue }
            
            categoryCell.deselectCell()
        }
        
        guard let categoryCell = categoriesCollectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }
        
        categoryCell.selectCell()
        
        guard let firstCategoryItemIndex = menuPresenter.items.firstIndex(where: { $0.category == categoryCell.category }) else { return }
        
        self.menuTableView.scrollToRow(at: IndexPath(row: firstCategoryItemIndex, section: 0), at: .top, animated: true)
    }
}

extension MenuViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = menuTableView.contentOffset.y
        promoNavigationView.promoCollectionView.isHidden = offsetY > 250
        print(offsetY)
        if offsetY <= 250 {
            promoNavigationView.snp.updateConstraints { make in
                make.height.equalTo(250 - offsetY)
            }
        } else {
            promoNavigationView.snp.updateConstraints { make in
                make.height.equalTo(1)
            }
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
