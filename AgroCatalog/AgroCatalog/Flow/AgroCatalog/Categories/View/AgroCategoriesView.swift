//
//  CategoriesView.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroCategoriesView: View {
    @StateObject var viewModel: AgroCategoriesViewModel
    @State var categories: [DrugCategory]?
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                if let categories {
                    Button(action: {
                        viewModel.coordinator?.push(.catalog(title: "Все категории"))
                    }, label: {
                        AgroAllCategoriesItem()
                    })
                    
                    ForEach(categories) { category in
                        Button(action: {
                            viewModel.coordinator?.push(.catalog(id: category.id, title: category.name))
                        }, label: {
                            AgroCategoryItem(category: category)
                        })
                    }
                } else {
                    placeholder
                }
            }
            .padding(.horizontal, 14)
        }
        .onReceive(viewModel.$categories, perform: { categories in
            self.categories = categories
        })
        .onAppear {
            Task {
                await viewModel.getCategories()
            }
        }
    }
    
    var placeholder: some View {
        Text("Categories not available")
            .foregroundStyle(.secondary)
            
    }
}

#Preview {
    let coordinator = AgroCoordinator()
    let viewModel = AgroCategoriesViewModel.build(coordinator: coordinator)
    
    return AgroCategoriesView(viewModel: viewModel)
}
