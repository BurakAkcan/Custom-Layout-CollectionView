//
//  Manager.swift
//  Basic-Flow-Layout
//
//  Created by Burak AKCAN on 1.11.2022.
//

import Foundation

final class Manager {
    static let shared = Manager()
    private init() {}
    
    func loadDatas() -> [Characters]? {
        guard let plistUrl = Bundle.main.url(forResource: "Character_Data", withExtension: "plist") else {
            return nil
        }
        let data = try? Data(contentsOf: plistUrl)
        return try? PropertyListDecoder().decode([Characters].self, from: data!)
    }
    
}
