//
//  Drugs.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

struct Drug: Codable, Identifiable {
    let id: Int
    let image: String?
    let categories: DrugsCategories
    let name: String
    let description: String
    let documentation: String?
    let fields: [Fields]
}

extension Drug {
    struct DrugsCategories: Codable {
        let id: Int
        let icon: String?
        let image: String?
        let name: String
    }
}

extension Drug {
    struct Fields: Codable {
        let typesId: Int
        let type: FieldsType
        let name: String
        let value: String?
        let image: String?
        let flags: FieldsFlags
        let show: Int
        let group: Int
        
        enum CodingKeys: String, CodingKey {
            case typesId = "types_id"
            case type, name, value, image, flags, show, group
        }
    }
}

extension Drug.Fields {
    struct FieldsFlags: Codable {
        let html: Int
        let noValue: Int
        let noName: Int
        let noImage: Int
        let noWrap: Int
        let noWrapName: Int
        let system: Int
        
        enum CodingKeys: String, CodingKey {
            case html, system
            case noValue = "no_value"
            case noName = "no_name"
            case noImage = "no_image"
            case noWrap = "no_wrap"
            case noWrapName = "no_wrap_name"
        }
    }
}

extension Drug.Fields {
    enum FieldsType: String, Codable {
        case text, image, gallery, text_block, list, button
        
        private enum RawValues: String, CodingKey {
            case text, image, gallery, list, button
            case textBlock = "text_block"
        }
    }
}


extension Drug {
    static var placeholder: Self {
        let url = Bundle.main.url(forResource: "Drug", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let drug = try! JSONDecoder().decode(Drug.self, from: data)
        return drug
    }
}

extension Drug {
    var searchTags: String {
        (self.id.formatted() + self.name + self.description).lowercased()
    }
}
