//
//  Coordinator.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Content: View
    associatedtype Router: NavigationRouter
    associatedtype Failure: LocalizedError
    
    var error: Failure? { get set }
    var hasError: Bool { get set }
    
    func build(route: Router) -> Content
    func push(_ page: Router)
    func pop()
    func presentError(_ error: Failure)
}
