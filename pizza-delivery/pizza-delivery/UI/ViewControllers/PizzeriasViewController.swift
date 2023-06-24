//
//  PizzeriasViewController.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit
import SPAlert

class PizzeriasViewController: UIViewController {

    lazy var pizzeriasTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(PizzeriaTableViewCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    lazy var pizzeriasPresenter: PizzeriasPresenter = {
        return PizzeriasPresenter(delegate: self)
    }()
    
    private var loadingAlert: SPAlertView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
    }
}

// MARK: -
// MARK: Setup interface methods
extension PizzeriasViewController {
    private func setupInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        self.navigationItem.title = "Pizzerias"
        loadingAlert = SPAlertView.loadingAlert
        setupLayout()
        setupConstraints()
    }
    
    private func setupLayout() {
        self.view.addSubview(pizzeriasTableView)
    }
    
    private func setupConstraints() {
        pizzeriasTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension PizzeriasViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzeriasPresenter.pizzerias.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PizzeriaTableViewCell.id, for: indexPath)
        guard let pizzeriaCell = cell as? PizzeriaTableViewCell else { return cell }
        
        pizzeriaCell.set(pizzeria: pizzeriasPresenter.pizzerias[indexPath.row])
        return pizzeriaCell
    }
}

extension PizzeriasViewController: PizzeriasPresenterDelegate {
    func reloadData() {
        loadingAlert?.dismiss()
        pizzeriasTableView.reloadData()
    }
}

extension PizzeriasViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pizzeriasPresenter.setPizzeria(index: indexPath.row)
        let mainTabBar = MainTabBarController(nibName: nil, bundle: nil)
        mainTabBar.modalPresentationStyle = .currentContext
        self.present(mainTabBar, animated: false)
    }
}
