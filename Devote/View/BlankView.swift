//
//  BlankView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/8/25.
//

import SwiftUI

struct BlankView: View {
	
	
	// MARK: - body
	
	var body: some View {
		VStack {
			Spacer()
		} // VStack
		.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
		.background(.black)
		.opacity(0.5)
		.edgesIgnoringSafeArea(.all)
	}
}


// MARK: - preview

struct BlankView_Previews: PreviewProvider {
	static var previews: some View {
		BlankView()
	}
}
