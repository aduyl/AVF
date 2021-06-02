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
    private let videoPlayer = VideoPlayer()
    private let videoPlayerView = VideoPlayerView(frame: .zero)
    private let progressView = UIProgressView(progressViewStyle: .bar)
    private let toolbarView = VideoPlayerToolbarView(frame: .zero)
    private var isPlaying = false
   
    init(video: Video) {
        self.video = video
        super.init(nibName: nil, bundle: nil)
        
        videoPlayer.delegate = self
        videoPlayer.attachTo(videoPlayerView: videoPlayerView)
        videoPlayer.attach(video: video)
        
        progressView.progress = 0.0
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(videoPlayerView)
        view.addSubview(progressView)
        view.addSubview(toolbarView)
        toolbarView.playButton.addTarget(self, action: #selector(didPressOnPlayButton), for: .touchUpInside)
        toolbarView.fastForvardButton.addTarget(self, action: #selector(didPressOnFastForvardButton), for: .touchUpInside)
        toolbarView.rewindButton.addTarget(self, action: #selector(didPressOnRewindButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutViews()
        videoPlayer.play()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutViews()
    }
    
    private func layoutViews() {
        let width = view.bounds.width
        let bottomOffset = view.safeAreaInsets.bottom
        let toolbarHeight: CGFloat = 50.0
        let progressHeight: CGFloat = 1.0
        let videoViewHeight = view.bounds.height - progressHeight - toolbarHeight - bottomOffset
        videoPlayerView.frame = CGRect(x: 0.0, y: 0.0, width: width, height: videoViewHeight)
        progressView.frame = CGRect(x: 0.0, y: videoViewHeight, width: width, height: progressHeight)
        toolbarView.frame = CGRect(x: 0.0, y: videoViewHeight + progressHeight, width: width, height: toolbarHeight)
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
        if videoPlayer.isPlaying {
            videoPlayer.pause()
        } else {
            videoPlayer.play()
        }
    }
    
    private func fastForwardPlaying(){
        videoPlayer.fastForward()
    }
    
    private func rewindPlaying(){
        videoPlayer.revindVideo()
    }
    
}

extension VideoPlayerController: VideoPlayerOutput {
    func videoPlayer(_ videoPlayer: VideoPlayer, didChangeProgress progress: Double) {
        progressView.progress = Float(progress)
    }
    
    func videoPlayer(_ videoPlayer: VideoPlayer, didChangeIsPlaying isPlaying: Bool) {
        if isPlaying {
            toolbarView.playButton.setImage(UIImage.init(systemName: "pause"), for: .normal)
        } else {
            toolbarView.playButton.setImage(UIImage.init(systemName: "play"), for: .normal)
        }
    }
}
