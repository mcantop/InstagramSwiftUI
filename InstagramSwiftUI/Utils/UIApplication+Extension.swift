//
//  UIApplication.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 14/11/2022.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
