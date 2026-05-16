//
//  NetworkError.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
    case noInternet
    case securityCompromised
}
