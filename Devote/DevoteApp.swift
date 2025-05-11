//
//  DevoteApp.swift
//  Devote
//
//  Created by Isaac Urbina on 5/6/25.
//

import SwiftUI

@main
struct DevoteApp: App {
	
	
	// MARK: - properties
	
	let persistenceController = PersistenceController.shared
	@AppStorage("isDarkMode") var isDarkMode: Bool = false
	
	
	// MARK: - body
	
	var body: some Scene {
		WindowGroup {
			ContentView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
				.preferredColorScheme(isDarkMode ? .dark : .light)
		}
	}
}
