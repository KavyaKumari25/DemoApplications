//
//  ImageLoader.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 01/03/22.
//

import SwiftUI

struct ImageLoader: View {
    
    var urlString: String
    var imageFrame: (width: CGFloat, height: CGFloat)
    
    var body: some View {
        AsyncImage(url: URL(string: urlString), content:view)
    }
    
    @ViewBuilder
    private func view(for phase: AsyncImagePhase) -> some View {
        switch phase {
        case .empty:
            ProgressView()
        case .success(let image):
            image
                .resizable()
                .frame(width:imageFrame.width, height: imageFrame.height)
                .cornerRadius(16)
        case .failure(let error):
            VStack(spacing: 16) {
                Image(systemName: "xmark.octagon.fill")
                    .foregroundColor(.red)
                Text(error.localizedDescription)
                    .multilineTextAlignment(.center)
            }
        @unknown default:
            Text("Unknown")
                .foregroundColor(.gray)
        }
    }
    
    var placeHolderImageView: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.gray)
            .frame(width:imageFrame.width, height: imageFrame.height)
            .cornerRadius(16)
    }
}

struct ImageLoadView_Previews: PreviewProvider {
    static var previews: some View {
        ImageLoader(urlString: "https://apod.nasa.gov/apod/image/1805/ObsUni_WikipediaPablo_960.jpg", imageFrame: (width: 300, height: 300))
    }
}
