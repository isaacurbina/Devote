//
//  BlankView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/8/25.
//

import SwiftUI

struct BlankView: View {
	
	
	// MARK: - properties
	
	var backgroundColor: Color
	var backgroundOpacity: Double
	
	
	// MARK: - body
	
	var body: some View {
		VStack {
			Spacer()
		} // VStack
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
		.background(backgroundColor)
		.opacity(backgroundOpacity)
		.blendMode(.overlay)
		.edgesIgnoringSafeArea(.all)
	}
}


// MARK: - preview

struct BlankView_Previews: PreviewProvider {
	static var previews: some View {
		BlankView(backgroundColor: .black, backgroundOpacity: 0.3)
			.background(BackgroundImageView())
			.background(backgroundGradient.ignoresSafeArea(.all))
	}
}
