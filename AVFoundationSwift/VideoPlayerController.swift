//
//  VideoPlayerController.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import UIKit


class VideoPlayerController: UIViewController {
    
    private var video: Video?
    func configure(video: Video){
            self.video = video
    }
    let videoPlayer = VideoView(video: video)
    
    @IBOutlet weak var lab: UILabel!
    override func viewDidLoad() {
            super.viewDidLoad()
        
            view.addSubview(videoPlayer)
            videoPlayer.frame = CGRect(x: 0, y: 0, width: 200, height: 600)
            videoPlayer.play()
            
            
        }
    @IBOutlet weak var playButton: UIButton!
    var check = true
    @IBAction func pushPlayButton(_ sender: Any){
        if check {
            self.playButton.setImage(UIImage(systemName:"pause" ), for: UIControl.State.init())
            check = !check
            //videoPlayer.stop()
        } else {
            self.playButton.setImage(UIImage(systemName:"play" ), for: UIControl.State.init())
            check = !check
           // videoPlayer.play()
        }
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
