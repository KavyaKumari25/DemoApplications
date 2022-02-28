//
//  HomeView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var vm: NasaDataViewModel
    var body: some View {
        VStack {
            SearchBarView(searchBarViewModel: vm.searchBarViewModel)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
            
            if vm.isLoading {
                Spacer()
                Text("Loading Data")
                ProgressView()
                Spacer()
            } else {
                if let nasaData = self.vm.nasaData {
                    DetailView(vm: vm)
                } else {
                    if self.vm.favoriteListData.count > 0, let record = vm.favoriteListData[0] {
                        DetailView(vm: NasaDataViewModel(savedData: record))
                    }
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
