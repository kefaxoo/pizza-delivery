//
//  String.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation

extension String {
    var toUnixFilename: String {
        let removeChars: Set<Character> = ["/", ">", "<", "|", ":", "&"]
        var newSelf = self
        newSelf.removeAll(where: { removeChars.contains($0) })
        return newSelf
    }
}
