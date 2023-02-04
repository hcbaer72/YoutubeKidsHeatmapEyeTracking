//
//  extensions.swift
//  youtubetest
//
//  Created by holly on 1/11/23.
//
import Foundation
import SwiftUI
import ReplayKit
import AVFoundation

//MARK: App recording extensions
extension View{
    
    // MARK: Start Recording
    func startRecording(enableMicrophone: Bool = false, completion: @escaping(Error?)->()){
        let recorder = RPScreenRecorder.shared()
        
        //Microphone Option
        recorder.isMicrophoneEnabled = false
        
        //Starting Recording
        recorder.startRecording(handler: completion)
    }
    //MARK: Stop recording
    //it will return the Recorded Video URL
    func stopRecording()async throws->URL{
        //file will be stored in temporary directory
        //video name
   //     let name = UUID().uuidString + ".mov"
        
      //  let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
    //   let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
       let url : URL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(UUID().description).mov")
        
        let recorder = RPScreenRecorder.shared()
        try await recorder.stopRecording(withOutput: url)
        
        return url
    }
  
    

    
    
    //MARK: cancel recording
  //  func cancelRecodring(){
  //      let recorder = RPScreenRecorder.shared()
   //     recorder.discardRecording{}
  //  }
}
