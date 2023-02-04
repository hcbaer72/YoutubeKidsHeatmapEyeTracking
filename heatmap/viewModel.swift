//
//  viewModel.swift
//  youtubetest
//
//  Created by holly on 1/11/23.
//
import Foundation
import Combine
import WebKit
import SwiftUI
import ReplayKit
import Photos


class ViewModel: ObservableObject {
    var webViewNavigationPublisher = PassthroughSubject<WebViewNavigation, Never>()
    var showWebTitle = PassthroughSubject<String, Never>()
    var showLoader = PassthroughSubject<Bool, Never>()
    var valuePublisher = PassthroughSubject<String, Never>()
}




// For identifiying WebView's forward and backward navigation
enum WebViewNavigation {
    case backward, forward, reload
}

// For identifying what type of url should load into WebView
enum WebUrlType {
    case localUrl, publicUrl
    
}
