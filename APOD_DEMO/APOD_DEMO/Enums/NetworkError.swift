//
//  NetworkError.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation

enum NetworkError: Error {

    /// The URL was invalid.
    case invalidURL

    /// The response was invalid and JSON parsing failed.
    case invalidResponse

    /// An error occurred but the exact reason is unknown or unvaluable.
    case unknownError(Error?)

}
