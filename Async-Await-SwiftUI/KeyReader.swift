//
//  KeyReader.swift
//  Async-Await-SwiftUI
//
//  Created by Ege Sucu on 13.05.2023.
//

import Foundation


class KeyReader {
    var accessKey: String?
    
    static let shared = KeyReader()
    
    init() {
        readKey()
    }
    
    func readKey() {
        if let file = Bundle.main.path(forResource: "Secrets", ofType: "txt") {
            do {
                accessKey = try String(contentsOfFile: file).replacingOccurrences(of: "\n", with: "")
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
