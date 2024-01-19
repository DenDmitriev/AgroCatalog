//
//  DrugCategory.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

struct DrugCategory: Codable, Identifiable {
    /*
     {
         "id": 7,
         "icon": "/upload/drugs/categories//protraviteli_08fd860e.png",
         "image": "/upload/drugs/categories//Протравитель_a928ffc8.png",
         "name": "Протравители"
     }
     */
    let id: Int
    let icon: String
    let image: String
    let name: String
}

extension DrugCategory {
    static var placeholder: Self {
        let url = Bundle.main.url(forResource: "Categories", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let categories = try! JSONDecoder().decode([DrugCategory].self, from: data)
        return categories.first!
    }
}
