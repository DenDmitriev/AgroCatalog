//
//  Router.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

enum AgroRouter: NavigationRouter {
    case category
    case catalog(id: DrugCategory.ID? = nil, title: String)
    case item(id: Drug.ID)
    
    var title: String {
        switch self {
        case .catalog:
            String(localized: "Каталог")
        case .item(_):
            ""
        case .category:
            String(localized: "Категории")
        }
    }
    
    @ViewBuilder func view(coordinator: AgroCoordinator) -> some View {
        switch self {
        case .catalog(let id, let title):
            AgroDrugCatalogView(viewModel: AgroDrugCatalogViewModel.build(coordinator: coordinator), selectedCategory: id, title: title)
        case .item(let id):
            AgroDrugView(drugId: id, viewModel: AgroDrugViewModel.build(coordinator: coordinator))
        case .category:
            AgroCategoriesView(viewModel: AgroCategoriesViewModel.build(coordinator: coordinator))
        }
    }
}

extension AgroRouter {
    var id: Self {
        self
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}
