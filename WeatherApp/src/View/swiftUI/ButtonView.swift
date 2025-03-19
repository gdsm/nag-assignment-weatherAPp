//
//  ButtonView.swift
//  WeatherApp
//
//  Created by Gagandeep
//

import SwiftUI

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
