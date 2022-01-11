//
//  PostError.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import Foundation

enum PostError : LocalizedError {
    case noData
    case thrownError(Error)
    case invalidURL
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
            
        case .noData:
            return "Server returned with no data"
        case .thrownError(let error):
            return "Error \(error.localizedDescription)"
        case .invalidURL:
            return "Server failed to reach the neecessary URL"
        case .unableToDecode:
            return "Unable to decode data"
        }
    }
} // End of enum
