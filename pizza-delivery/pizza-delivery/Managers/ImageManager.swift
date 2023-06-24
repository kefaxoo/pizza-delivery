//
//  ImageManager.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import UIKit

final class ImageManager {
    private static func getImageAsync(link: String) async throws -> UIImage? {
        guard let url = URL(string: link) else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let gResponse = response as? HTTPURLResponse,
                  gResponse.statusCode >= 200, gResponse.statusCode < 300,
                  let image = UIImage(data: data)
            else { return nil }
            
            return image
        } catch {
            throw error
        }
    }
    
    
    static func saveImage(link: String, url: URL?) {
        guard let url else { return }
        Task { @MainActor in
            let image = try await getImageAsync(link: link)
            try image?.pngData()?.write(to: url)
        }
    }
    
    static func loadImage(url: URL?) -> UIImage? {
        guard let url,
              let data = try? Data(contentsOf: url)
        else { return nil }
        
        return UIImage(data: data)
    }
}
