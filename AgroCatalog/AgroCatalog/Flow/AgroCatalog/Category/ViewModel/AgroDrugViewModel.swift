//
//  AgroDrugViewModel.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

class AgroDrugViewModel: ObservableObject {
    weak var coordinator: AgroCoordinator?
    @Published var drug: Drug?
    
    func getDrug(by dragId: Int) async {
        do {
//            let url = Bundle.main.url(forResource: "Drugs", withExtension: "json")!
//            let data = try Data(contentsOf: url)
            let data = try await NetworkService.request(method: .catalogItem(id: dragId))
            let drugs = try JSONDecoder().decode(Drug.self, from: data)
            DispatchQueue.main.async {
                self.drug = drugs
            }
        } catch {
            print(error.localizedDescription)
            if let error = error as? LocalizedError {
                coordinator?.presentError(AgroError.map(errorDescription: error.localizedDescription))
            }
        }
    }
}

extension AgroDrugViewModel {
    static func build(coordinator: AgroCoordinator) -> AgroDrugViewModel {
        let viewModel = AgroDrugViewModel()
        viewModel.coordinator = coordinator
        
        return viewModel
    }
}
