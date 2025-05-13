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
	@State private var showNewTaskItem: Bool = false
	@AppStorage("isDarkMode") private var isDarkMode: Bool = false
	
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
				
				
				// MARK: - main view
				
				VStack{
					
					
					// MARK: - header
					
					HStack(spacing: 10) {
						
						// title
						Text("Devore")
							.font(.system(.largeTitle, design: .rounded))
							.fontWeight(.heavy)
							.padding(.leading, 4)
						
						// edit button
						EditButton()
							.font(.system(size: 16, weight: .semibold, design: .rounded))
							.padding(.horizontal, 10)
							.frame(minWidth: 70, minHeight: 24)
							.background(
								Capsule().stroke(.white, lineWidth: 2)
							)
						
						// appearance button
						Button(action: {
							// toggle appearance
							isDarkMode.toggle()
						}) {
							Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
								.resizable()
								.frame(width: 24, height: 24)
								.font(.system(.title, design: .rounded))
						}
						
					} // HStack
					.padding()
					.foregroundColor(.white)
					
					Spacer(minLength: 80)
					
					
					// MARK: - new task button
					
					Button(action: {
						showNewTaskItem = true
					}) {
						Image(systemName: "plus.circle")
							.font(.system(size: 30, weight: .semibold, design: .rounded))
						Text("New Task")
							.font(.system(size: 24, weight: .bold, design: .rounded))
					}
					.foregroundColor(.white)
					.padding(.horizontal, 20)
					.padding(.vertical, 15)
					.background(
						LinearGradient(gradient: Gradient(colors: [Color.pink, Color.blue]), startPoint: .leading, endPoint: .trailing)
							.clipShape(Capsule())
					)
					.shadow(
						color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 8, x: 0.0, y: 4.0
					)
					
					
					// MARK: - tasks
					
					
					List {
						ForEach(items) { item in
							ListRowItemView(item: item)
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
				.blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
				.transition(.move(edge:.bottom))
				.animation(.easeOut(duration: 0.5))
				
				
				// MARK: - new task item
				
				if showNewTaskItem {
					BlankView(
						backgroundColor: isDarkMode ?.black : .white,
						backgroundOpacity: isDarkMode ? 0.3 : 0.5
					)
					.onTapGesture {
						withAnimation() {
							showNewTaskItem = false
						}
					}
					NewTaskItemView(isShowing: $showNewTaskItem)
				}
				
			} // ZStack
			.onAppear() {
				UITableView.appearance().backgroundColor = UIColor.clear
			}
			.navigationBarHidden(true)
			.background(
				BackgroundImageView()
					.blur(radius: showNewTaskItem ? 8.0 : 0, opaque: false)
			)
			.background(
				backgroundGradient.ignoresSafeArea(.all)
			)
			
		} // NavigationView
		.navigationViewStyle(StackNavigationViewStyle())
	}
	
	
	// MARK: - functions
	
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
