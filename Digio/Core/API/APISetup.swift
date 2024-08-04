//
//  APISetup.swift
//  Digio
//
//  Created by Wellington Nascente Hirsch on 29/07/2024.
//

import Foundation

enum APISetup {
    static let baseURL = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/"
}

enum APIRequest {
    
    static var products: URLRequest? {
        guard let url = URL(string: "\(APISetup.baseURL)products") else {
            return nil
        }
        return URLRequest(url: url)
    }
}

enum APIError: Error {
    case decodingError
    case networkError
    case unknown
    
    init(_ error: Error?) {
        guard let error else {
            self = .unknown
            return
        }
        
        switch error {
        case APIError.decodingError:
            self = .decodingError
        case APIError.networkError:
            self = .networkError
        default:
            self = .unknown
        }
    }
    
    var localized: String {
        switch self {
        case .decodingError:
            return "error.decodingError".localized
        case .networkError:
            return "error.networkError".localized
        case .unknown:
            return "error.unknown".localized
        }
    }
}
