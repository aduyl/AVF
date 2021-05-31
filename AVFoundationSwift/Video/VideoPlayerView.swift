//
//  VideoPlayerView.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    var player: AVPlayer? {
      get {
        return playerLayer.player
      }

      set {
        playerLayer.player = newValue
      }
    }
    
    // 5 Override the layerClass
    override class var layerClass: AnyClass {
      return AVPlayerLayer.self
    }
    
    // 6 Add accessor for playerLayer so you don't need to
    var playerLayer: AVPlayerLayer {
      return layer as! AVPlayerLayer
    }
    
}
