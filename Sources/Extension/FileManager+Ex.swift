//
//  FileManager.swift
//  Extension
//
//  Created by SaitoYuta on 2017/11/03.
//

import Foundation

extension FileManager: AsuhaCompatible {}
extension Asuha where Base == FileManager {

    public func generatePath(_ path: String) throws -> String {
        let url = URL.init(fileURLWithPath: path)
        if !base.fileExists(atPath: url.deletingLastPathComponent().absoluteString) {
            try base.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true, attributes: nil)
        }
        if !base.fileExists(atPath: path) {
            base.createFile(atPath: path, contents: nil, attributes: nil)
        }
        return path
    }
}
