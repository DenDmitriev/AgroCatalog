//
//  DrugView.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroDrugView: View {
    
    @State var drugId: Int
    @State var drug: Drug?
    @Environment(\.dragStore) var dragStore
    @StateObject var viewModel: AgroDrugViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            if let drug {
                ScrollView {
                    ZStack {
                        // Category icon
                        AsyncImage(url: NetworkService.url(for: drug.categories.icon)) { icon in
                            icon
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: 32)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                        .padding(16)
                        
                        // Favorite icon
                        Button(action: {
                            if isFavorite {
                                dragStore.favorites.remove(drug.id)
                            } else {
                                dragStore.favorites.insert(drug.id)
                            }
                        }, label: {
                            Image(isFavorite ? "StarFill" : "Star")
                                .aspectRatio(contentMode: .fit)
                                .font(.title)
                            
                        })
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(16)
                        .foregroundStyle(isFavorite ? Color.accentColor : .secondary)
                        
                        // Drug image
                        AsyncImage(url: NetworkService.url(for: drug.image)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 215)
                        .padding(16)
                    }
                    
                    VStack(spacing: 16) {
                        // Title and description
                        VStack(alignment: .leading, spacing: 8) {
                            Text(drug.name)
                                .font(.title3.weight(.semibold))
                            
                            Text(drug.description)
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                                .lineLimit(9)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Action
                        Link(destination: URL(string: "https://shans-group.com/kontakty/gde-kupit/")!, label: {
                            Label("Где купить", image: "GeoMarkIcon")
                        })
                        .buttonStyle(.primary)
                    }
                }
            } else {
                placeholder
            }
        }
        .padding(14)
        .onReceive(viewModel.$drug, perform: { drug in
            self.drug = drug
        })
        .onAppear {
            Task {
                await viewModel.getDrug(by: drugId)
            }
        }
    }
    
    var placeholder: some View {
        Text("Drug not available")
            .foregroundStyle(.secondary)
    }
    
    var isFavorite: Bool {
        if let drug {
            dragStore.favorites.contains(drug.id)
        } else {
            false
        }
    }
}

#Preview {
    let coordinator = AgroCoordinator()
    let viewModel = AgroDrugViewModel.build(coordinator: coordinator)
    
    return AgroDrugView(drugId: 83, viewModel: viewModel)
}
