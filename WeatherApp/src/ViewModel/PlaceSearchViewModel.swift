//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by gagandeep on 18/03/25.
//

import SwiftUI
import Combine
import Logging

final class PlaceSearchViewModel: ObservableObject, @unchecked Sendable {
    @Published var searchText = ""
    @Published var suggestions: [String] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let repo: PlaceSearchRepoProtocol

    init(repo: PlaceSearchRepoProtocol) {
        self.repo = repo
        // Debounce input to avoid excessive API calls
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // Throttle API calls
            .removeDuplicates() // Ignore duplicate inputs
            .sink { [weak self] text in
                // TODO: Integrate google sdk for auto complete
//                self?.performSearch(query: text)
            }
            .store(in: &cancellables)
    }
    
    private func performSearch(query: String) {
        guard query.count >= 3 else { // Only search after 3 characters
            self.suggestions = []
            return
        }

        Task { @MainActor [weak self] in
            do {
                let result = try await self?.repo.performSearch(query: query)
                DispatchQueue.main.async {
                    self?.suggestions = result?.predictions.map { $0.description } ?? []
                }
            } catch {
                Log.error("Error in fetching places: \(error)")
            }
        }
    }
}
