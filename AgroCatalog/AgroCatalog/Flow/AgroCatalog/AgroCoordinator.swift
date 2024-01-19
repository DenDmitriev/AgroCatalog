//
//  Coordinator.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

class AgroCoordinator: ObservableObject, Coordinator {
    @Published var path = NavigationPath()
    @Published var error: AgroError?
    @Published var hasError: Bool = false
    
    // MARK: - Navigation
    func build(route: AgroRouter) -> some View {
        route.view(coordinator: self)
    }
    
    func push(_ page: AgroRouter) {
        path.append(page)
    }
    
    func pop() {
        path.removeLast()
    }
        
    // Error presenter
    func presentError(_ error: AgroError) {
        DispatchQueue.main.async {
            self.error = error
            self.hasError = true
        }
    }
}
