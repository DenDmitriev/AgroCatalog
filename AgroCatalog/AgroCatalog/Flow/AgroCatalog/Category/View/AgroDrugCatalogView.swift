//
//  AgroCatalogView.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroDrugCatalogView: View {
    @StateObject var viewModel: AgroDrugCatalogViewModel
    @State var selectedCategory: DrugCategory.ID?
    @State var title: String
    @State var drugs: [Drug]?
    @State var favorites = Set<Drug.ID>()
    @State var searchText: String = ""
    @State var isSearching: Bool = false
    
    let columns: [GridItem] = Array(repeating: GridItem(.flexible(), spacing: 16, alignment: .top), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                if let drugs {
                    ForEach(
                        isSearching && !searchText.isEmpty
                        ? drugs.filter({ $0.searchTags.contains(searchText.lowercased()) })
                        : drugs
                    ) { drug in
                        AgroDrugItem(drug: drug)
                            .onTapGesture {
                                viewModel.coordinator?.push(.item(id: drug.id))
                            }
                    }
                } else {
                    placeholder
                }
            }
            .padding(16)
        }
        .onReceive(viewModel.$drugs, perform: { drugs in
            self.drugs = drugs
        })
        .onAppear {
            Task {
                await viewModel.getCatalog(by: selectedCategory)
            }
        }
        .navigationTitle(title)
        .toolbarBackground(Color.accentColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isSearching.toggle() }) {
                    Image("Magnifyingglass")
                        .foregroundStyle(.white)
                }
            }
        })
        .searchable(
            text: $searchText,
            isPresented: $isSearching,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "Search index..."
        )
    }
    
    var placeholder: some View {
        Text("Drugs not available")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            let coordinator = AgroCoordinator()
            let viewModel = AgroDrugCatalogViewModel.build(coordinator: coordinator)
            
            NavigationStack {
                AgroDrugCatalogView(viewModel: viewModel, selectedCategory: 2, title: "Title")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    return PreviewWrapper()
}
