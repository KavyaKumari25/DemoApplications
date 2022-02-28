//
//  APODNetworkService.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation
import Combine

class NetworkService {
    
    func fetchNasaData(on dateString: String = "", with completion: @escaping (Result<NasaDataModel, NetworkError>) -> Void) {
        
        var nasaDataUrl = "https://api.nasa.gov/planetary/apod?api_key=hSaWhJVKKRr4YIGhhy2WYcuIuHBU2gJ3z4N1dEUk"
        
        if dateString.count > 0 {
            nasaDataUrl = nasaDataUrl + "&date=" + dateString
        }
        
        guard let url = URL(string: nasaDataUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.unknownError(error)))
                return
            }
            
            do {
                let nasaData = try JSONDecoder().decode(NasaDataModel.self, from: data)
                print(nasaData)
                completion(.success(nasaData))
            } catch let error as NSError {
                NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
                
            }
        }
        task.resume()
    }
} 
