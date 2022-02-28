//
//  ContentView.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 25/02/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject var nasaDataViewModel = NasaDataViewModel()
    
    var body: some View {
        TabBarView()
            .environmentObject(self.nasaDataViewModel)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
