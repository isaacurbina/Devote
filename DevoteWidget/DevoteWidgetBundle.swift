//
//  DevoteWidgetBundle.swift
//  DevoteWidget
//
//  Created by Isaac Urbina on 5/14/25.
//

import WidgetKit
import SwiftUI

@main
struct DevoteWidgetBundle: WidgetBundle {
	var body: some Widget {
		DevoteWidget()
		DevoteWidgetControl()
		DevoteWidgetLiveActivity()
	}
}
