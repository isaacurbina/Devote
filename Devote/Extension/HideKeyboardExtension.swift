//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by Isaac Urbina on 5/7/25.
//

import SwiftUI

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to :nil, from: nil, for: nil)
	}
}
#endif
