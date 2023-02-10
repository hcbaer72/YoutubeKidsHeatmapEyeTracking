//
//  heatmapview.swift
//  youtubetest
//
//  Created by Kristen Lineback on 2/3/23.
//
import SwiftUI
import UIKit
import SceneKit
import ARKit

struct HeatMapView: UIViewControllerRepresentable {
    @State var scene = ARSCNView()
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
    let viewController = HeatMapViewController()
        viewController.sceneView = scene
        
       return viewController // original
    
    }
    
    
}
