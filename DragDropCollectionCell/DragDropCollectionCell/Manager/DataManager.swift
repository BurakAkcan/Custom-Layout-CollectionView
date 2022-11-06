//
//  DataMAnager.swift
//  DragCollectionCell
//
//  Created by Burak AKCAN on 3.11.2022.
//

import Foundation

final class DataManager {
    
    private init() {}
    static let shared = DataManager()
    
    func getDatas() -> [Lesson]? {
        guard let plistUrl = Bundle.main.url(forResource: "DersData", withExtension: "plist") else {
            return nil
        }
        if let data = try? Data(contentsOf: plistUrl) {
            return try? PropertyListDecoder().decode([Lesson].self, from: data)
        }else {
            return nil
        }
    }
}
