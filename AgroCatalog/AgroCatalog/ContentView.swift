//
//  ContentView.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var coordinator: AgroCoordinator
    
    var body: some View {
        AgroCoordinatorView(coordinator: coordinator)
    }
}

#Preview {
    ContentView(coordinator: AgroCoordinator())
}
