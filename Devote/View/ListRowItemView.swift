//
//  ListRowItemView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/12/25.
//

import SwiftUI

struct ListRowItemView: View {
	
	
	// MARK: - properties
	
	@Environment(\.managedObjectContext) var viewContext
	@ObservedObject var item: Item
	
	
	// MARK: - body
	
	var body: some View {
		Toggle(isOn: $item.completion) {
			
			Text(item.task ?? "")
				.font(.system(.title2, design: .rounded))
				.fontWeight(.heavy)
				.foregroundColor(item.completion ? .pink : .primary)
				.padding(.vertical, 12)
				.animation(.default)
			
		} // Toggle
		.toggleStyle(CheckboxStyle())
		.onReceive(item.objectWillChange, perform: { _ in
			if self.viewContext.hasChanges {
				try? self.viewContext.save()
			}
		})
	}
}
