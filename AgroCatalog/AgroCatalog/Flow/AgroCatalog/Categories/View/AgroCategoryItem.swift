//
//  AgroCategoryItem.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroCategoryItem: View {
    
    @State var category: DrugCategory
    
    var body: some View {
        ZStack {
            AsyncImage(url: NetworkService.url(for: category.image)) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity)
            
            HStack {
                AsyncImage(url: NetworkService.url(for: category.icon)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 32)
                
                Text(category.name)
                    .font(.title.weight(.semibold))
                    .foregroundStyle(.white)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(height: 125)
    }
}

#Preview {
    AgroCategoryItem(category: .placeholder)
}
