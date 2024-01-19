//
//  PrimaryButtonStyle.swift
//  AgroCatalog
//
//  Created by Denis Dmitriev on 19.01.2024.
//

import SwiftUI

public struct PrimaryButtonStyle : PrimitiveButtonStyle {
    public func makeBody(configuration: BorderedButtonStyle.Configuration) -> some View {
        Button(action: {
            configuration.trigger()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.border)
                
                HStack {
                    configuration.label
                        .font(.body.weight(.semibold))
                        .labelStyle(.iconOnly)
                    
                    configuration.label
                        .font(.caption.weight(.semibold))
                        .labelStyle(.titleOnly)
                        .textCase(.uppercase)
                        .foregroundStyle(Color.primary)
                }
            }
            .frame(height: 36)
        })
    }
}

extension PrimitiveButtonStyle where Self == BorderedButtonStyle {
    public static var primary: PrimaryButtonStyle { .init() }
}
