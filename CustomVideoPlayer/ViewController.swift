//
//  ViewController.swift
//  AVFoundationSwift
//
//  Created by mac on 27.05.2021.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var videoURL: UITextField!
    @IBAction func goToVideo(_ sender: Any) {
        guard let link = self.videoURL.text, let url = URL(string: link) else {
            self.showAlert(alertText: "Wrong link")
            return
        }
        
        let video = Video(url: url)
        let playerController = VideoPlayerController(video: video)
        navigationController?.pushViewController(playerController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //videoURL.text = "https://wolverine.raywenderlich.com/content/ios/tutorials/video_streaming/foxVillage.m3u8"
    }
    
    func showAlert(alertText: String) {
        let alertController = UIAlertController(title: "Error", message: alertText, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

