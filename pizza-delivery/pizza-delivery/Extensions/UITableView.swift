//
//  UITableView.swift
//  pulse-mvvm
//
//  Created by Bahdan Piatrouski on 14.06.23.
//

import UIKit

extension UITableView {
    func register(_ cells: AnyClass...) {
        cells.forEach { cell in
            let id = String(describing: cell.self)
            self.register(cell, forCellReuseIdentifier: id)
        }
    }
    
    var cells: [UITableViewCell] {
        var cells = [UITableViewCell]()
        for i in 0..<self.numberOfSections {
            for j in 0..<self.numberOfRows(inSection: i) {
                guard let cell = self.cellForRow(at: IndexPath(row: j, section: i)) else { continue }
                
                cells.append(cell)
            }
        }
        
        return cells
    }
}
