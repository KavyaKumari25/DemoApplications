//
//  DetailView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 27/02/22.
//

import SwiftUI

struct DetailView: View {
    
    @ObservedObject var vm: NasaDataViewModel
    @State var isButttonClicked: Bool = false
    @State var isFavorite: Bool = false
    
    var body: some View {
    
        VStack {
            HStack {
                Text(vm.nasaData?.title ?? "")
                    .font(.headline)
                Spacer()
                Button(action: {
                    vm.updateFavoriteList(nasaData: vm.nasaData)
                }) {
                    if vm.isFavoriteRecord {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.theme.accent)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(Color.theme.accent)
                    }
                }
            }
            
            ScrollView(showsIndicators: false) {
                
                VStack(alignment:.leading, spacing: 20){
                    
                    if vm.nasaData?.mediaType == MediaType.image.rawValue {
                        ImageLoader(urlString: vm.nasaData?.imageURLString ?? "", imageFrame: (width: 300, height: 250))
                    }
                    
                    Text(vm.nasaData?.date ?? "")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Copyright:")
                            .font(.headline)
                            .fontWeight(.semibold)
                        Text(vm.nasaData?.copyright ?? "-")
                    }
                    
                    Text(vm.nasaData?.explanation ?? "-")
                        .font(.subheadline)
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vm: NasaDataViewModel())
            
            
    }
}
