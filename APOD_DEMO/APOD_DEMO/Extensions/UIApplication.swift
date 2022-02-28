//
//  UIApplication.swift
//  APOD_DEMO
//
//  Created by Kumari, Kavya on 28/02/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
