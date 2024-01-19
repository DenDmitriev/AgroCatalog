//
//  AgroAllCategoriesItem.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroAllCategoriesItem: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.secondary)
            
            Text("Все категории")
                .font(.title.weight(.semibold))
        }
        .frame(height: 125)
    }
}

#Preview {
    AgroAllCategoriesItem()
}
