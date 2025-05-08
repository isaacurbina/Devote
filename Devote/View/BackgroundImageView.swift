//
//  BackgroundImageView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/8/25.
//

import SwiftUI

struct BackgroundImageView: View {
	var body: some View {
		Image("rocket")
			.antialiased(true)
			.resizable()
			.scaledToFill()
			.ignoresSafeArea(.all)
	}
}


// MARK: - preview

struct BackgroundImageView_Previews: PreviewProvider {
	static var previews: some View {
		BackgroundImageView()
	}
}
