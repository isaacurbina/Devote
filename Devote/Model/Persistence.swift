//
//  Persistence.swift
//  Devote
//
//  Created by Isaac Urbina on 5/6/25.
//

import CoreData

struct PersistenceController {
	
	
	// MARK: - 1. persistent controller
	
	static let shared = PersistenceController()
	
	
	// MARK: - 2. persistent container
	
	let container: NSPersistentContainer
	
	
	// MARK: - 3. initialization (load the persistent store)
	
	init(inMemory: Bool = false) {
		container = NSPersistentContainer(name: "Devote")
		if inMemory {
			container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		container.viewContext.automaticallyMergesChangesFromParent = true
	}
	
	
	// MARK: - 4. preview
	
	@MainActor
	static let preview: PersistenceController = {
		let result = PersistenceController(inMemory: true)
		let viewContext = result.container.viewContext
		for i in 0..<10 {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
			newItem.task = "Sample task No\(i)"
			newItem.completion = false
			newItem.id = UUID()
		}
		do {
			try viewContext.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
		return result
	}()
}
