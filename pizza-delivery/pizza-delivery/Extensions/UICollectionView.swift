//
//  UICollectionView.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 23.06.23.
//

import UIKit

extension UICollectionView {
    func register(_ cells: AnyClass...) {
        cells.forEach { cell in
            let id = String(describing: cell.self)
            self.register(cell, forCellWithReuseIdentifier: id)
        }
    }
    
    var cells: [UICollectionViewCell] {
        var cells = [UICollectionViewCell]()
        for i in 0..<self.numberOfSections {
            for j in 0..<self.numberOfItems(inSection: i) {
                guard let cell = self.cellForItem(at: IndexPath(row: j, section: i)) else { continue }
                
                cells.append(cell)
            }
        }
        
        return cells
    }
}
