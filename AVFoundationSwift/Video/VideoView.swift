//
//  VideoView.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import UIKit
import AVFoundation

class VideoView: UIView {
    let video: Video
    let videoPlayerView = VideoPlayerView()
    
    @objc private let player = AVPlayer()
    private var token: NSKeyValueObservation?
    init(video: Video) {
        self.video = video
        super.init(frame: .zero)
        
        addSubview(videoPlayerView)
        initializePlayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayerView.frame = bounds
    }
    
    private func addVideoToPlayer() {
        let asset = AVURLAsset(url: video.url)
        let item = AVPlayerItem(asset: asset)
        player.replaceCurrentItem(with: item)
    }
    
    private func initializePlayer() {
        videoPlayerView.player = player
        addVideoToPlayer()
       
        player.play()
    }
    
    func pause() {
      player.pause()
    }

    func play() {
      player.play()
    }
}

