//
//  NasaDataViewModel.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import Foundation
import Combine

class NasaDataViewModel: ObservableObject {
    
    @Published var nasaData: NasaDataModelProtocol?
    @Published var isLoading: Bool = false
    @Published var searchBarViewModel: SearchBarViewModel
    private var cancellable = Set<AnyCancellable>()
    private let favoriteDataService = FavoriteDataService()
    @Published var favoriteListData: [NasaRecordEntity] = []
    
    init() {
        searchBarViewModel = SearchBarViewModel()
        self.fetchNasaAPODDetails(forQueryDateString: "")
        self.setUpTriggerSearchEvent()
        self.setUpSubscriptionForFavoriteList()
    }
    
    convenience init(savedData: NasaRecordEntity) {
        self.init()
        nasaData = NasaDataModel(id: savedData.id ?? UUID(), title: savedData.title ?? "", explanation: savedData.explaination ?? "", date: savedData.date ?? "", mediaType: savedData.mediaType ?? "", copyright: savedData.copyright, imageURLString: "", imageHDURLString: "")
        
    }
    
    var isFavoriteRecord: Bool {
        
        return favoriteListData.filter { $0.title == nasaData?.title }
            .count > 0
        
    }
    
    func updateFavoriteList(nasaData: NasaDataModelProtocol?) {
        if nasaData != nil {
            favoriteDataService.updateFavoriteList(nasaData: nasaData!)
        }
    }
    
    func deleteRecordFromFavoriteList(entity: NasaRecordEntity) {
        favoriteDataService.delete(entity: entity)
    }
    
    func fetchNasaAPODDetails(forQueryDateString: String) {
        
        isLoading = true
        let service = NetworkService()
        service.fetchNasaData(on: forQueryDateString) { [weak self] result in
            
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .failure(let error):
                    print("error message \(error.localizedDescription)")
                case .success(let nasaData):
                    self?.nasaData = nasaData
                }
                
            }
        }
    }
    
    func setUpSubscriptionForFavoriteList() {
        self.favoriteDataService.$savedEntities
            .sink { [weak self] savedEntities in
                self?.favoriteListData = savedEntities
        }.store(in: &cancellable)
    }
    
    func setUpTriggerSearchEvent() {
        self.searchBarViewModel.triggerSearch.sink {[weak self] _ in
            if self?.isAValidDateFormat(dateString: self?.searchBarViewModel.searchText) == true {
                self?.fetchNasaAPODDetails(forQueryDateString: (self?.searchBarViewModel.searchText)!)
            } else {
                self?.fetchNasaAPODDetails(forQueryDateString: "")
            }
           
        }.store(in: &cancellable)
    }
    
    private func isAValidDateFormat(dateString: String?) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if dateFormatter.date(from: dateString ?? "") != nil {
            return true
        }
        return false
    }
}
