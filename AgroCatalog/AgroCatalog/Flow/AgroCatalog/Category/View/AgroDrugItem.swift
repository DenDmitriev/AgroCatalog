//
//  AgroDrugItem.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroDrugItem: View {
    
    @State var drug: Drug
    
    var body: some View {
        VStack(spacing: 12) {
            AsyncImage(url: NetworkService.url(for: drug.image)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ProgressView()
            }
            .frame(maxHeight: 82)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            VStack(alignment: .leading, spacing: 6) {
                Text(drug.name)
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.primary)
                
                Text(drug.description)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
                    .lineLimit(9)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.background)
                .shadow(color: .black.opacity(0.15), radius: 4)
        }
        
    }
}

#Preview {
    AgroDrugItem(drug: .placeholder)
        .padding()
}
