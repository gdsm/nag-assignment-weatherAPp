//
//  NetworkMocking.swift
//  WeatherAppTests
//
//  Created by Gagandeep
//

import Foundation
import XCTest

class MockURLProtocol: URLProtocol {
    private static var registry: [String: (URLRequest) throws -> Result<(HTTPURLResponse, Data?), Error>?] = [:]

    static func register(
        tag: String,
        handler: @escaping (URLRequest) throws -> Result<(HTTPURLResponse, Data?), Error>?
    ) {
        registry[tag] = handler
    }

    static func unregister(tag: String) {
        registry.removeValue(forKey: tag)
    }

    override class func canInit(with task: URLSessionTask) -> Bool {
        return true
    }

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override func startLoading() {
        guard let client = client else {
            return
        }

        // find the entry meant to handle this request
        let responses = Self.registry.compactMap { _, handler -> Result<(HTTPURLResponse, Data?), Error>? in
            do {
                return try handler(request)
            } catch {
                XCTFail(error.localizedDescription)
                return nil
            }
        }

        guard responses.count == 1, let result = responses.first else {
            XCTFail("Unexpected response handlers count: \(responses.count)")
            return
        }

        switch result {
        case let .success((response, data)):
            client.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            if let data = data {
                client.urlProtocol(self, didLoad: data)
            }
            client.urlProtocolDidFinishLoading(self)

        case let .failure(error):
            client.urlProtocol(self, didFailWithError: error)
        }
    }

    // MARK: - required methods not needed for mocking
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func stopLoading() {}
}
