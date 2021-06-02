//
//  VideoPlayerController.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import UIKit
import AVKit

class VideoPlayerController: UIViewController {
    
    private let video: Video
    private let videoView: VideoView
    private let toolbarView = VideoPlayerToolbarView(frame: .zero)
    private var isPlaying = false
   
    
    init(video: Video) {
        self.video = video
        self.videoView = VideoView(video: video)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        view.addSubview(toolbarView)
        toolbarView.playButton.addTarget(self, action: #selector(didPressOnPlayButton), for: .touchUpInside)
        toolbarView.fastForvardButton.addTarget(self, action: #selector(didPressOnFastForvardButton), for: .touchUpInside)
        toolbarView.rewindButton.addTarget(self, action: #selector(didPressOnRewindButton), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
                
        let width = view.bounds.width
        let bottomOffset = view.safeAreaInsets.bottom
        let toolbarHeight: CGFloat = 50.0
        let videoViewHeight = view.bounds.height - toolbarHeight - bottomOffset
        videoView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: videoViewHeight)
        toolbarView.frame = CGRect(x: 0.0, y: videoViewHeight, width: width, height: toolbarHeight)
        switchPlaying()
    }
    
    @objc private func didPressOnPlayButton() {
        switchPlaying()
    }
    
    @objc private func didPressOnFastForvardButton() {
        fastForwardPlaying()
    }
    
    @objc private func didPressOnRewindButton() {
        rewindPlaying()
    }
    
    
    private func switchPlaying() {
        if isPlaying {
            videoView.pause()
            toolbarView.playButton.setImage(UIImage.init(systemName: "pause"), for: .normal)
        } else {
            videoView.play()
            toolbarView.playButton.setImage(UIImage.init(systemName: "play"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    private func fastForwardPlaying(){
        videoView.fastForward()
        
    }
    
    private func rewindPlaying(){
        videoView.revindVideo()
    }
    
}
