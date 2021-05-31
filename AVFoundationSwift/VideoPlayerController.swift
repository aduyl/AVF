//
//  VideoPlayerController.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import UIKit


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
    
//    private var video: Video?
//    func configure(video: Video){
//            self.video = video
//    }
//    let videoPlayer = VideoView(video: video)
    
//    @IBOutlet weak var lab: UILabel!

//    @IBOutlet weak var playButton: UIButton!
//    var check = true
    
    
//     в идеале нужено брать статус из плеера
//    private var isPlaying: Bool {
//        return videoView.isPlaying
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(videoView)
        view.addSubview(toolbarView)
        toolbarView.playButton.addTarget(self, action: #selector(didPressOnPlayButton), for: .touchUpInside)
//        videoPlayer.frame = CGRect(x: 0, y: 0, width: 200, height: 600)
//        videoPlayer.play()
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
    
    private func switchPlaying() {
        if isPlaying {
            videoView.pause()
        } else {
            videoView.play()
        }
        isPlaying = !isPlaying
    }
    
//    @IBAction func pushPlayButton(_ sender: Any){
//        if check {
//            self.playButton.setImage(UIImage(systemName:"pause" ), for: UIControl.State.init())
//            check = !check
//            //videoPlayer.stop()
//        } else {
//            self.playButton.setImage(UIImage(systemName:"play" ), for: UIControl.State.init())
//            check = !check
//           // videoPlayer.play()
//        }
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
