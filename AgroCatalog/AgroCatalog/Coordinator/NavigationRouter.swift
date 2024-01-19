//
//  Router.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

protocol NavigationRouter<Content>: Identifiable, Hashable {
    associatedtype Content: View
    associatedtype SomeCoordinator: Coordinator
    
    var title: String { get }
    func view(coordinator: SomeCoordinator) -> Content
}
