//
//  SearchBarViewModel.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 01/03/22.
//

import Foundation
import Combine

class SearchBarViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var isFocused: Bool = false
    @Published var clearSearch: Bool = false
    let triggerSearch = PassthroughSubject<Void, Never>()
    let triggerClearSearch = PassthroughSubject<Void, Never>()
    
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        debounceTextChanges()
    }
    
    func debounceTextChanges() {
        $searchText.debounce(for: 2, scheduler: RunLoop.main)
            .sink {_ in
                self.onSearchTextChange()
            }
            .store(in: &disposeBag)
    }
    
    
    func searchTriggered() {
        //Trigger Search
       self.triggerSearch.send()
        
    }
    
    func searchCleared() {
        //Clear Search - clear search text
        self.triggerSearch.send()
    }
    
    func onSearchTextChange() {
        if searchText.count > 0 {
            print("new text value: \(searchText)")
            self.searchTriggered()
        }
        else {
            self.searchCleared()
        }
    }
    
    func onSubmitCalled() {
        self.onSearchTextChange()
    }
    
    func resetSearchBar() {
        self.searchText = ""
        self.isFocused = false
    }
}

