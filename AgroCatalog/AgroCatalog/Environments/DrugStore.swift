//
//  DrugStore.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

class DrugStore: ObservableObject {
    @Published var favorites: Set<Drug.ID> = []
}

private struct DrugStoreKey: EnvironmentKey {
    // 1
    static let defaultValue: DrugStore = DrugStore()

}

extension EnvironmentValues {
    var dragStore: DrugStore {
        get { self[DrugStoreKey.self] }
        set { self[DrugStoreKey.self] = newValue }
    }
}
