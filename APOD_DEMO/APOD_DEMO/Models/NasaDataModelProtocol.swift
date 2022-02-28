//
//  NasaDataModelProtocol.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation

protocol NasaDataModelProtocol {
    var id: UUID { get }
    var title: String { get }
    var explanation: String { get }
    var date: String { get }
    var mediaType: String { get }
    var copyright: String? { get }
    var imageURLString: String? { get }
    var imageHDURLString: String? { get }
}
