//
//  LocationsViewController.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit
import SPAlert

class LocationsViewController: UIViewController {

    lazy var locationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(LocationTableViewCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var locationsPresenter: LocationsPresenter = {
        return LocationsPresenter(delegate: self)
    }()
    
    private var loadingAlert: SPAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension LocationsViewController {
    private func setupInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationItem.title = "Locations"
        loadingAlert = SPAlertView.loadingAlert
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(locationsTableView)
    }
    
    private func setupConstraints() {
        locationsTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationsPresenter.locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.id, for: indexPath)
        guard let locationCell = cell as? LocationTableViewCell else { return cell }
        
        locationCell.set(location: locationsPresenter.locations[indexPath.row])
        return locationCell
    }
}

extension LocationsViewController: LocationsPresenterDelegate {
    func reloadData() {
        loadingAlert?.dismiss()
        locationsTableView.reloadData()
    }
}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationsPresenter.setLocation(index: indexPath.row)
        let pizzeriasVC = PizzeriasViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(pizzeriasVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
