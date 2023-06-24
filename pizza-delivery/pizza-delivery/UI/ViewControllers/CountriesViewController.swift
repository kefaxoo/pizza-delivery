//
//  CountriesViewController.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 22.06.23.
//

import UIKit
import SnapKit
import SPAlert

class CountriesViewController: UIViewController {

    lazy var countriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(CountryTableViewCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var countriesPresenter: CountriesPresenter = {
        return CountriesPresenter(delegate: self)
    }()
    
    private var loadingAlert: SPAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension CountriesViewController {
    private func setupInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        loadingAlert = SPAlertView.loadingAlert
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(countriesTableView)
    }
    
    private func setupConstraints() {
        countriesTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension CountriesViewController: CountriesPresenterDelegate {
    func reloadData() {
        loadingAlert?.dismiss()
        countriesTableView.reloadData()
    }
}

extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesPresenter.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.id, for: indexPath)
        guard let countryCell = cell as? CountryTableViewCell else { return cell }
        
        countryCell.set(country: countriesPresenter.countries[indexPath.row])
        return countryCell
    }
}

extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countriesPresenter.setCountry(index: indexPath.row)
        let locationsVC = LocationsViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(locationsVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
