//
//  SearchBarView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 28/02/22.
//

import SwiftUI

struct SearchBarView: View {
    
    @ObservedObject var searchBarViewModel: SearchBarViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchBarViewModel.searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent)
            
            TextField("Search by date yyyy-MM-dd", text: $searchBarViewModel.searchText)
                .foregroundColor(Color.theme.accent)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .padding()
                        .offset(x: 10)
                        .foregroundColor(Color.theme.accent)
                        .opacity(searchBarViewModel.searchText.isEmpty ? 0.0 : 1.0)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchBarViewModel.searchText = ""
                        }
                    ,alignment: .trailing
                )
                .onSubmit {
                    searchBarViewModel.onSubmitCalled()
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.15), radius: 10, x: 0, y: 0)
        )
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchBarViewModel: SearchBarViewModel())
    }
}
