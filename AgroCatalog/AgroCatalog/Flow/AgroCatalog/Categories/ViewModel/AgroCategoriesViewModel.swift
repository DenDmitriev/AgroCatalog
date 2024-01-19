//
//  CategoriesViewModel.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

class AgroCategoriesViewModel: ObservableObject {
    weak var coordinator: AgroCoordinator?
    @Published var categories: [DrugCategory] = []
    
    func getCategories() async {
        do {
//            let url = Bundle.main.url(forResource: "Categories", withExtension: "json")!
//            let data = try Data(contentsOf: url)
            let data = try await NetworkService.request(method: .categories)
            let categories = try JSONDecoder().decode(Array<DrugCategory>.self, from: data)
            DispatchQueue.main.async {
                self.categories = categories
            }
        } catch {
            print(error.localizedDescription)
            if let error = error as? LocalizedError {
                coordinator?.presentError(AgroError.map(errorDescription: error.localizedDescription))
            }
        }
    }
}

extension AgroCategoriesViewModel {
    static func build(coordinator: AgroCoordinator) -> AgroCategoriesViewModel {
        let viewModel = AgroCategoriesViewModel()
        viewModel.coordinator = coordinator
        
        return viewModel
    }
}
