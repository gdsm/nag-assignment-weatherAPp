//
//  SearchRepo.swift
//  WeatherApp
//
//  Created by gagandeep on 18/03/25.
//

import NetworkServices

protocol PlaceSearchRepoProtocol {
    func performSearch(query: String) async throws -> PlaceSearchResponse
}

struct PlaceSearchResponse: Codable {
    let predictions: [Prediction]
}

struct Prediction: Codable {
    let description: String
}

final class PlaceSearchRepo: BaseRepo, PlaceSearchRepoProtocol {
    
    let urlBuilder: URLBuilder
    let networkInterface: NetworkProtocol
    
    // MARK: Init methods
    init(urlBuilder: URLBuilder, networkInterface: NetworkProtocol) {
        self.urlBuilder = urlBuilder
        self.networkInterface = networkInterface
    }

    internal func buildUrl(query: String, secondaryUrl: String) -> URL? {
        let urlString = "\(urlBuilder.getPlaceSearchBaseUrl())?input=\(query)&key=\(urlBuilder.getPlaceSearchApiAppId())&types=(cities)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: urlString)
    }

    func performSearch(query: String) async throws -> PlaceSearchResponse {
        guard let url = buildUrl(query: query, secondaryUrl: "weather") else {
            throw ServiceError.unknown
        }
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        return try await networkInterface.request(urlRequest: request)
    }
}
