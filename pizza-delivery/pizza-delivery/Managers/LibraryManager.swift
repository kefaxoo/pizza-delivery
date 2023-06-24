//
//  LibraryManager.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation

final class LibraryManager {
    static func getAbsolutePath(filename: String, path: FileManager.SearchPathDirectory) -> URL? {
        return FileManager.default.urls(for: path, in: .userDomainMask).first?.appending(path: filename)
    }
    
    static func createDirectories() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsUrl = URL(string: paths[0])!
        print(documentsUrl.absoluteString)
        
        // MARK: -
        // MARK: Create images directory
        
        let imagesPath = documentsUrl.appendingPathComponent("Images")
        if !FileManager.default.fileExists(atPath: imagesPath.path()) {
            do {
                try FileManager.default.createDirectory(atPath: imagesPath.path(), withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
        
        // MARK: -
        // MARK: Create items images directory
        
        let itemsImagesPath = documentsUrl.appendingPathComponent("Images/Items")
        if !FileManager.default.fileExists(atPath: itemsImagesPath.path()) {
            do {
                try FileManager.default.createDirectory(atPath: itemsImagesPath.path(), withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
        
        // MARK: -
        // MARK: Create promo images directory
        
        let promoImagesPath = documentsUrl.appendingPathComponent("Images/Promos")
        if !FileManager.default.fileExists(atPath: promoImagesPath.path()) {
            do {
                try FileManager.default.createDirectory(atPath: promoImagesPath.path(), withIntermediateDirectories: true)
            } catch {
                print(error)
            }
        }
    }
    
    static func isFileExists(url: URL?) -> Bool {
        guard let url else { return false }
        
        return FileManager.default.fileExists(atPath: url.absoluteString)
    }
}
