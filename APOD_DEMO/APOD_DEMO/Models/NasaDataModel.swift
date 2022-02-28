//
//  NasaDataModel.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation

struct NasaDataModel: NasaDataModelProtocol, Decodable, Identifiable {
    
    var id: UUID
    let title: String
    let explanation: String
    let date: String
    let mediaType: String
    let copyright: String?
    let imageURLString: String?
    let imageHDURLString: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case explanation
        case date
        case mediaType = "media_type"
        case copyright
        case imageURLString = "url"
        case imageHDURLString = "hdurl"
    }
}

extension NasaDataModel {
    public init(from decoder: Decoder) throws {
        
        do {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = UUID()
            title = try values.decode(String.self, forKey: .title)
            explanation = try values.decode(String.self, forKey: .explanation)
            
            date = try values.decode(String.self, forKey: .date)
            
            mediaType = try values.decode(String.self, forKey: .mediaType)
            
            copyright = try? values.decode(String.self, forKey: .copyright)
            
            imageURLString = try? values.decode(String.self, forKey: .imageURLString)
            
            imageHDURLString = try? values.decode(String.self, forKey: .imageHDURLString)
            
        } catch let error {
            throw error
        }
    }
    
    init(id: UUID, title: String, copyright: String?, date: String, explanation: String, hdurl: String?, media_type: String, url: String) {
        self.id = id
        self.title = title
        self.copyright = copyright
        self.date = date
        self.explanation = explanation
        self.imageHDURLString = hdurl
        self.mediaType = media_type
        self.imageURLString = url
    }
}
