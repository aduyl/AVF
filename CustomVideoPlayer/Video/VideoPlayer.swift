import Foundation
import AVFoundation

protocol VideoPlayerOutput: NSObjectProtocol {
    func videoPlayer(_ videoPlayer: VideoPlayer, didChangeProgress progress: Double)
    func videoPlayer(_ videoPlayer: VideoPlayer, didChangeIsPlaying isPlaying: Bool)
}

class VideoPlayer {
    private let player = AVPlayer()
    private var playerItem: AVPlayerItem?
    private var timeStatusObserveToken: NSKeyValueObservation?

    weak var delegate: VideoPlayerOutput?
    private(set) var isPlaying: Bool = false {
        didSet {
            if isPlaying != oldValue {
                delegate?.videoPlayer(self, didChangeIsPlaying: isPlaying)
            }
        }
    }
    private(set) var progress: Double = 0.0 {
        didSet {
            if progress != oldValue {
                delegate?.videoPlayer(self, didChangeProgress: progress)
            }
        }
    }
    
    init() {
        player.actionAtItemEnd = .pause
        timeStatusObserveToken = player.observe(\.timeControlStatus, changeHandler: { [weak self] _, _ in
            self?.updateIsPlaying()
        })
    }
    
    func attach(video: Video) {
        let asset = AVURLAsset(url: video.url)
        let item = AVPlayerItem(asset: asset)
        playerItem = item
        player.replaceCurrentItem(with: item)
    }
    
    func attachTo(videoPlayerView: VideoPlayerView) {
        videoPlayerView.player = player
        
        let observeInterval = CMTime(seconds: 1.0 / 30.0, preferredTimescale: .nsecPerSec)
        player.addPeriodicTimeObserver(forInterval: observeInterval, queue: DispatchQueue.main) { [weak self] _ in
            self?.updateProgress()
        }
    }
    
    func play() {
        if playerItem != nil {
            player.play()
        }
    }
    
    func pause() {
        player.pause()
    }
    
    func fastForward(forwardTime: Double = 15.0){
        guard let item = playerItem else { return }
        
        let currentTime = item.currentTime().seconds
        let totalTime = item.duration.seconds
        if totalTime - currentTime < forwardTime {
            let time = CMTime(seconds: Double(totalTime), preferredTimescale: .nsecPerSec)
            item.seek(to: time, completionHandler: nil)
        } else {
            let time = CMTime(seconds: Double(currentTime + forwardTime), preferredTimescale: .nsecPerSec)
            item.seek(to: time, completionHandler: nil)
        }
    }
    
    func revindVideo(rewindTime: Double = 15.0) {
        guard let item = playerItem else { return }
        
        let currentTime = item.currentTime().seconds
        if currentTime < rewindTime {
            let time = CMTime(seconds: 0.0, preferredTimescale: .nsecPerSec)
            item.seek(to: time, completionHandler: nil)
        } else {
            let time = CMTime(seconds: Double(currentTime - rewindTime), preferredTimescale: .nsecPerSec)
            item.seek(to: time, completionHandler: nil)
        }
    }
    
    private func updateProgress() {
        guard let item = playerItem else { return }
        
        let duration = item.duration.seconds
        let currentTime = item.currentTime().seconds
        
        if duration > 0 && duration != Double.nan {
            progress = currentTime / duration
        } else {
            progress = 0.0
        }
    }
    
    private func updateIsPlaying() {
        switch player.timeControlStatus {
        case .playing:
            isPlaying = true
            
        case .waitingToPlayAtSpecifiedRate:
            isPlaying = false
            
        case .paused:
            isPlaying = false
            
        @unknown default:
            return
        }
    }
}

fileprivate extension CMTimeScale {
    static var nsecPerSec = CMTimeScale(NSEC_PER_SEC)
}
