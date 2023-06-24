//
//  RealmManager.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation
import RealmSwift

final class RealmManager<T> where T: Object {
    private let realm = try! Realm()
    
    func write(object: T) {
        try? realm.write {
            realm.add(object)
        }
    }
    
    func read() -> [T] {
        return Array(realm.objects(T.self))
    }
    
    func update(realmBlock: @escaping((Realm) -> Void)) {
        realmBlock(self.realm)
    }
    
    func delete(object: T) {
        try? realm.write {
            realm.delete(object)
        }
    }
}

