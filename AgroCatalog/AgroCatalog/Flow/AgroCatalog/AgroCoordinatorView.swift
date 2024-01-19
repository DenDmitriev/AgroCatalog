//
//  CoordinatorView.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct AgroCoordinatorView: View {
    @StateObject var coordinator: AgroCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.build(route: .category)
                .navigationDestination(for: AgroRouter.self, destination: { route in
                    route.view(coordinator: coordinator)
                })
                .alert(isPresented: $coordinator.hasError, error: coordinator.error) { error in
                    Button("Ok", action: {})
                } message: { error in
                    Text(error.failureReason ?? "")
                }
                .navigationTitle(AgroRouter.category.title)
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.accentColor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .padding(.vertical)

        }
        .environmentObject(coordinator)
    }
}

#Preview {
    AgroCoordinatorView(coordinator: AgroCoordinator())
}
