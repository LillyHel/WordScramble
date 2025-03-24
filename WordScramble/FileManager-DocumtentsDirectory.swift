//
//  FileManager-DocumtentDirectory.swift
//  WordScramble
//
//  Created by Lilly on 03.09.24.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
