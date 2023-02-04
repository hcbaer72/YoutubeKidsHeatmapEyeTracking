//
//  ContentView.swift
//  youtubetest
//
//  Created by holly on 1/11/23.
//
import SwiftUI
import ReplayKit
import Photos


struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var showLoader = false
    @State var message = ""
    @State var webTitle = ""
    @State private var startRecord = false
    @State private var stopRecord = false
    
    
    
    // For WebView's forward and backward navigation
    var webViewNavigationBar: some View {
        VStack(spacing: 0) {
            
            Divider()
            HStack {
                Spacer()
                Button(action: {
                    self.viewModel.webViewNavigationPublisher.send(.backward)
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                
                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }
                Button(action: {
                    self.viewModel.webViewNavigationPublisher.send(.forward)
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray)
                }
                Group {
                    Spacer()
                    Divider()
                    Spacer()
                }
                Button(action: {
                    self.viewModel.webViewNavigationPublisher.send(.reload)
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20, weight: .regular))
                        .imageScale(.large)
                        .foregroundColor(.gray).padding(.bottom, 4)
                }
                Spacer()
            }.frame(height: 45)
            Divider()
        }
    }
    
    
    
    // Recording status
    @State var isRecording: Bool = false
    @State var url: URL?
 //   let eyeTracking = EyeTracking(configuration: Configuration(appID: "ios-eye-tracking-example", blendShapes: [.eyeBlinkLeft, .eyeBlinkRight]))

    
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                /* Here I created a text field that takes string value and when send
                 button is clicked 'viewModel.valuePublisher' sends that value to WebView
                 then WebView sends that value to web app that you will load. In this
                 project's local .html file can not receive it because it is static you should
                 test with a web app then it will work because static website can not receive values
                 at runtime where dynamic web app can */
                
                HStack {
                    
                    TextField("Write message", text: $message).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: {
                        self.viewModel.valuePublisher.send(self.message)
                    })
                    {
                        Text("Send")
                            .padding(.trailing, 10)
                            .padding(.leading, 10)
                            .padding(.top, 4)
                            .padding(.bottom, 4)
                            .overlay (
                                RoundedRectangle(cornerRadius: 4, style: .circular)
                                    .stroke(Color.gray, lineWidth: 0.5)
                            )
                    }
                    
                    
                }.padding()
                
                Text(webTitle).font(.title).onReceive(self.viewModel.showWebTitle.receive(on: RunLoop.main)) { value in
                    self.webTitle = value
                }
                
                /* This is our WebView. Here if you pass .localUrl it will load LocalWebsite.html file
                 into the WebView and if you pass .publicUrl it will load the public website depending on
                 your url provided. See WebView implementation for more info. */
                
                
                WebView(url: .publicUrl, viewModel: viewModel).overlay (
                    RoundedRectangle(cornerRadius: 4, style: .circular)
                        .stroke(Color.gray, lineWidth: 0.5)
                ).padding(.leading, 20).padding(.trailing, 20)
                
                webViewNavigationBar
                
                //recording button
                    .overlay (alignment:.bottomTrailing) {
                        //MARK: Recording button
                        Button {
                            if isRecording{
                                //stopping since its async task
                                Task{
                                    do{
                                        self.url = try await stopRecording()
                                        print(self.url)
                                        
                                        //stop screen recording
                                        isRecording = false
                                        print("is recording: \(isRecording) ")
                                        
                                        //stop eye tracking
                             //      eyeTracking.endSession()
                                        
                                        
                                        // Exports all `Session`s as a `String`, converting the keys to snake case
                                       // ***let stringSessions = try? EyeTracking.exportAllString(with: .convertToSnakeCase)
                                        
                                        
                                    }
                                    catch{
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                            else{
                                startRecording { error in
                                    if let error = error{
                                        print(error.localizedDescription)
                                        return
                                    }
                                    //success
                                    //start screen recording
                                    isRecording = true
                                    print("is recording: \(isRecording) ")
                                    
//                                    //start eye tracking
//                                    eyeTracking.startSession()
                                    
//
//                                    //show eye tracking pointer
//                                   eyeTracking.pointer.backgroundColor = .red
//                                    eyeTracking.showPointer()
                                    
                                    
                                }
                                
                            }
                        } label: {
                            Image(systemName: isRecording ? "record.circle.fill" : "record.circle")
                                .font(.largeTitle)
                                .foregroundColor(isRecording ? .red : .green)
                        }
                        
                    }
                
                //}.onReceive(self.viewModel.showLoader.receive(on: //RunLoop.main)) { value in
                //self.showLoader = value
                //}
                
                // A simple loader that is shown when WebView is loading any page and hides when loading is finished.
                //   if showLoader {
                //     Loader()
                // }
            }
            HeatMapView()
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
