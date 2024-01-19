//
//  AgroCatalogApp.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

@main
struct AgroCatalogApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let coordinator = AgroCoordinator()
            
            ContentView(coordinator: coordinator)
        }
    }
}
