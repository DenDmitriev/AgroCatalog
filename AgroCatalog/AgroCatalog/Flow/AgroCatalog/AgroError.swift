//
//  AgroError.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import Foundation

enum AgroError: Error {
    case unknown
    case map(errorDescription: String)
}

extension AgroError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unknown:
            return String(localized: "Unknown error")
        case .map(let errorDescription):
            return errorDescription
        }
    }
}
