//
//  RowView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 28/02/22.
//

import SwiftUI

struct RowView: View {
    var imageURLString: String
    var title: String
    var postedOn: String
    var copyright: String
    var isFavorite: Bool = false
    var action: () -> Void
    
    var body: some View {
        HStack() {
            ImageLoader(urlString: imageURLString, imageFrame: (width: 80, height: 80))
            VStack(spacing:10) {
                Text(title)
                    .font(.subheadline)
                Text(postedOn)
                    .font(.caption)
                Text(copyright)
                    . font(.caption)
            }
            Spacer()
            Button {
                action()
            } label: {
                
                if isFavorite {
                    Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                }
                
            }
            .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 0))
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(imageURLString: "https://apod.nasa.gov/apod/image/0909/startrails_bury.jpg", title: "Star Trails Over Oregon", postedOn: "2009-09-09", copyright: "Discovery", action: {})
    }
}
