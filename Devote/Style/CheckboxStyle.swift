//
//  CheckboxStyle.swift
//  Devote
//
//  Created by Isaac Urbina on 5/12/25.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
	
	
	// MARK: - body
	
	func makeBody(configuration: Configuration) -> some View {
		return HStack {
			Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
				.foregroundColor(configuration.isOn ? .pink : .primary)
				.font(.system(size: 30, weight: .semibold, design: .rounded))
				.onTapGesture {
					configuration.isOn.toggle()
				}
			
			configuration.label
		} // HStack
	}
}


// MARK: - preview

struct CheckboxStyle_Previews: PreviewProvider {
	static var previews: some View {
		Toggle("Placeholder label", isOn: .constant(true))
			.toggleStyle(CheckboxStyle())
			.padding()
			.previewLayout(.sizeThatFits)
	}
}
