//
//  AgroCatalogViewModel.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

class AgroDrugCatalogViewModel: ObservableObject {
    weak var coordinator: AgroCoordinator?
    @Published var drugs: [Drug] = []
    
    func getCatalog(by catalogId: Int?) async {
        do {
//            let url = Bundle.main.url(forResource: "Drugs", withExtension: "json")!
//            let data = try Data(contentsOf: url)
            let data = try await NetworkService.request(method: .catalog(id: catalogId))
            let drugs = try JSONDecoder().decode(Array<Drug>.self, from: data)
            DispatchQueue.main.async {
                self.drugs = drugs
            }
        } catch {
            print(error.localizedDescription)
            if let error = error as? LocalizedError {
                coordinator?.presentError(AgroError.map(errorDescription: error.localizedDescription))
            }
        }
    }
}

extension AgroDrugCatalogViewModel {
    static func build(coordinator: AgroCoordinator) -> AgroDrugCatalogViewModel {
        let viewModel = AgroDrugCatalogViewModel()
        viewModel.coordinator = coordinator
        
        return viewModel
    }
}
