//
//  heatmapApp.swift
//  heatmap
//
//  Created by holly on 2/3/23.
//

import SwiftUI

@main
struct heatmapApp: App {
    var body: some Scene {
        WindowGroup {
            //ContentView()
            HeatMapView()
                .frame(width: 800, height: 1024)
        }
    }
}
