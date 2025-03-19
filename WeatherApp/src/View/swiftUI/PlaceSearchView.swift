//
//  SearchView.swift
//  WeatherApp
//
//  Created by gagandeep on 18/03/25.
//

import SwiftUI

struct PlaceSearchView: View {
    @ObservedObject var viewModel: PlaceSearchViewModel
    @Binding var navigationPath: NavigationPath

    var body: some View {
        VStack {
            // Search Bar
            TextField("Search city...", text: $viewModel.searchText)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                .submitLabel(.done)
                .onSubmit {
                    navigationPath.append(AppNavigation.forecastPlace)
                }
            
            // List of city suggestions
            List(viewModel.suggestions, id: \.self) { city in
                Text(city)
            }
        }
    }
}
