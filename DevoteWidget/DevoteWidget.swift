//
//  DevoteWidget.swift
//  DevoteWidget
//
//  Created by Isaac Urbina on 5/14/25.
//

import WidgetKit
import SwiftUI


// MARK: - timeline provider

struct Provider: TimelineProvider {
	func placeholder(in context: Context) -> SimpleEntry {
		SimpleEntry(date: Date(), emoji: "😀")
	}
	
	func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
		let entry = SimpleEntry(date: Date(), emoji: "😀")
		completion(entry)
	}
	
	func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
		var entries: [SimpleEntry] = []
		
		// Generate a timeline consisting of five entries an hour apart, starting from the current date.
		let currentDate = Date()
		for hourOffset in 0 ..< 5 {
			let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
			let entry = SimpleEntry(date: entryDate, emoji: "😀")
			entries.append(entry)
		}
		
		let timeline = Timeline(entries: entries, policy: .atEnd)
		completion(timeline)
	}
	
	//    func relevances() async -> WidgetRelevances<Void> {
	//        // Generate a list containing the contexts this widget is relevant in.
	//    }
}

struct SimpleEntry: TimelineEntry {
	let date: Date
	let emoji: String
}


// MARK: - widget

struct DevoteWidgetEntryView : View {
	
	
	// MARK: - properties
	
	@Environment(\.widgetFamily) var widgetFamily
	var entry: Provider.Entry
	var fontStyle: Font {
		return if widgetFamily == .systemSmall {
			.system(.footnote, design: .rounded)
		} else {
			.system(.headline, design: .rounded)
		}
	}
	
	
	// MARK: - body
	
	var body: some View {
		GeometryReader { geometry in
			ZStack {
				backgroundGradient
				
				Image("rocket-small")
					.resizable()
					.scaledToFit()
				
				Image("logo")
					.resizable()
					.frame(
						width: widgetFamily != .systemSmall ? 56 : 36,
						height: widgetFamily != .systemSmall ? 56 : 36
					)
					.offset(
						x: (geometry.size.width / 2) - 20,
						y: (geometry.size.height / -2) + 20
					)
					.padding(.top, widgetFamily != .systemSmall ? 32 : 12)
					.padding(.trailing, widgetFamily != .systemSmall ? 32 : 12)
				
				HStack {
					Text("Just Do It")
						.foregroundColor(.white)
						.font(fontStyle)
						.fontWeight(.bold)
						.padding(.horizontal, 12)
						.padding(.vertical, 4)
						.background(
							Color(red: 0, green: 0, blue: 0, opacity: 0.5)
								.blendMode(.overlay)
						)
						.clipShape(Capsule())
					
					if widgetFamily != .systemSmall {
						Spacer()
					}
				} // HStack
				.padding()
				.offset(y: (geometry.size.height / 2) - 24)
				
			} // ZStack
		} // GeometryReader
	}
}


// MARK: - widget

struct DevoteWidget: Widget {
	let kind: String = "DevoteWidget"
	
	var body: some WidgetConfiguration {
		StaticConfiguration(kind: kind, provider: Provider()) { entry in
			if #available(iOS 17.0, *) {
				DevoteWidgetEntryView(entry: entry)
					.containerBackground(.fill.tertiary, for: .widget)
			} else {
				DevoteWidgetEntryView(entry: entry)
					.padding()
					.background()
			}
		}
		.configurationDisplayName("Devote Launcher")
		.description("This is an example widget for the personal task manager app.")
	}
}


// MARK: - previews

#Preview(as: .systemSmall) {
	DevoteWidget()
} timeline: {
	SimpleEntry(date: .now, emoji: "😀")
	SimpleEntry(date: .now, emoji: "🤩")
}

#Preview(as: .systemMedium) {
	DevoteWidget()
} timeline: {
	SimpleEntry(date: .now, emoji: "😀")
	SimpleEntry(date: .now, emoji: "🤩")
}

#Preview(as: .systemLarge) {
	DevoteWidget()
} timeline: {
	SimpleEntry(date: .now, emoji: "😀")
	SimpleEntry(date: .now, emoji: "🤩")
}
