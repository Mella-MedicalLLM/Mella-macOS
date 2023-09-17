//
//  PersistentStorageName.swift
//  Mella-macOS
//
//  Created by 이전희 on 2023/09/17.
//

import Foundation

enum PersistentStorageNames: String {
    case mellaDataStorage = "MellaDataStorage"
    
    var name: String {
        self.rawValue
    }
}
