//
//  FavoriteListView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 28/02/22.
//

import SwiftUI

struct FavoriteListView: View {
    
    @EnvironmentObject var vm: NasaDataViewModel
    var body: some View {
        NavigationView{
            List {
                ForEach(vm.favoriteListData) { record in
                    RowView(imageURLString: record.imageUrl ?? "", title: record.title ?? "", postedOn: record.date ?? "", copyright: record.copyright ?? "", isFavorite: true, action: { vm.deleteRecordFromFavoriteList(entity: record) })
                }
            }
            .navigationTitle("My favorites")
        }
    }
}

struct FavoriteListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteListView()
    }
}
