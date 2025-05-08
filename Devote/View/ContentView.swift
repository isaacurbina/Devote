//
//  ContentView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/6/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
	
	
	// MARK: - property
	
	@State var task: String = ""
	private var isButtonDisabled: Bool {
		task.isEmpty
	}
	// fetching data
	@Environment(\.managedObjectContext) private var viewContext
	@FetchRequest(
		sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
		animation: .default)
	private var items: FetchedResults<Item>
	
	
	// MARK: - body
	
	var body: some View {
		NavigationView {
			ZStack {
				VStack{
					VStack(spacing: 16) {
						
						TextField("New Task", text: $task)
							.padding()
							.background(Color(UIColor.systemGray6))
							.cornerRadius(10)
						
						Button(action: {
							addItem()
						}) {
							Spacer()
							Text("SAVE")
							Spacer()
						} // Button
						.disabled(isButtonDisabled)
						.padding()
						.font(.headline)
						.foregroundColor(.white)
						.background(isButtonDisabled ? .gray : .pink)
						.cornerRadius(10)
						
					} // VStack
					.padding()
					
					List {
						ForEach(items) { item in
							NavigationLink {
								
								VStack(alignment: .leading) {
									Text(item.task ?? "")
										.font(.headline)
										.fontWeight(.bold)
									
									Text("Item at \(item.timestamp!, formatter: itemFormatter)")
										.font(.footnote)
										.foregroundColor(.gray)
								} // VStack
								
							} label: {
								
								VStack(alignment: .leading) {
									Text(item.task ?? "")
										.font(.headline)
										.fontWeight(.bold)
									
									Text(item.timestamp!, formatter: itemFormatter)
										.font(.footnote)
										.foregroundColor(.gray)
								} // VStack
							}
						}
						.onDelete(perform: deleteItems)
					} // List
					.scrollContentBackground(.hidden)
					.background(Color.clear)
					.listStyle(InsetGroupedListStyle())
					.shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
					.padding(.vertical, 0)
					.frame(maxWidth: 640)
					
				} // VStack
			} // ZStack
			.onAppear() {
				UITableView.appearance().backgroundColor = UIColor.clear
			}
			.navigationBarTitle("Daily Tasks", displayMode: .large)
			.toolbar {
				ToolbarItem(placement: .navigationBarLeading) {
					EditButton()
				}
			} // toolbar
			.background(
				BackgroundImageView()
			)
			.background(
				backgroundGradient.ignoresSafeArea(.all)
			)
			
		} // NavigationView
		.navigationViewStyle(StackNavigationViewStyle())
	}
	
	
	// MARK: - functions
	
	private func addItem() {
		withAnimation {
			let newItem = Item(context: viewContext)
			newItem.timestamp = Date()
			newItem.task = task
			newItem.completion = false
			newItem.id = UUID()
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
			
			task = ""
			hideKeyboard()
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			offsets.map { items[$0] }.forEach(viewContext.delete)
			
			do {
				try viewContext.save()
			} catch {
				let nsError = error as NSError
				fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
			}
		}
	}
}


// MARK: - preview

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
	}
}
