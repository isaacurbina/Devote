//
//  NewTaskItemView.swift
//  Devote
//
//  Created by Isaac Urbina on 5/8/25.
//

import SwiftUI

struct NewTaskItemView: View {
	
	
	// MARK: - properties
	
	@Environment(\.managedObjectContext) private var viewContext
	@State private var task: String = ""
	@Binding var isShowing: Bool
	private var isButtonDisabled: Bool {
		task.isEmpty
	}
	@AppStorage("isDarkMode") private var isDarkMode: Bool = false
	
	
	// MARK: - body
	
	var body: some View {
		VStack {
			Spacer()
			
			VStack(spacing: 16) {
				
				TextField("New Task", text: $task)
					.foregroundColor(.pink)
					.font(.system(size: 24, weight: .bold, design: .rounded))
					.padding()
					.background(
						isDarkMode ? Color(UIColor.systemGray6) : Color(UIColor.secondarySystemBackground)
					)
					.cornerRadius(10)
				
				Button(action: {
					addItem()
					playSound(sound: "sound-ding", type: "mp3")
					feedback.notificationOccurred(.success)
				}) {
					Spacer()
					
					Text("SAVE")
						.font(.system(size: 24, weight: .bold, design: .rounded))
					
					Spacer()
					
				} // Button
				.disabled(isButtonDisabled)
				.onTapGesture {
					if isButtonDisabled {
						playSound(sound: "sound-tap", type: "mp3")
						feedback.notificationOccurred(.error)
					}
				}
				.padding()
				.foregroundColor(.white)
				.background(isButtonDisabled ? .blue : .pink)
				.cornerRadius(10)
				
			} // VStack
			.padding(.horizontal)
			.padding(.vertical, 20)
			.background(
				isDarkMode ? Color(UIColor.secondarySystemBackground) : .white
			)
			.cornerRadius(16)
			.shadow(
				color: Color(red: 0, green: 0, blue: 0, opacity: 0.65),
				radius: 24
			)
			.frame(maxWidth: 640)
			
		} // VStack
		.padding()
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
			isShowing = false
		}
	}
}


// MARK: - preview

struct NewTaskItemView_Previews: PreviewProvider {
	static var previews: some View {
		NewTaskItemView(isShowing: .constant(true))
			.background(Color.gray.edgesIgnoringSafeArea(.all))
	}
}
