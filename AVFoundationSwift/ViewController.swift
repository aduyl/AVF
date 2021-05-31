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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    let performVideo = "performVideo"
    @IBOutlet weak var videoURL: UITextField!
    @IBAction func goToVideo(_ sender: Any) {
        guard let link = self.videoURL.text, link.isValidURL
        else{
            self.showAlert(alertText: "Wrong link")
            
            return
        }
        performSegue(withIdentifier: performVideo, sender: link)
        self.videoURL.text = ""
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == performVideo {
            guard let link = sender as? String,
                  let dst = segue.destination as? VideoPlayerController
            else {return}
            dst.configure(video: Video(url: URL(string: link)!))
         }
    }
    
    func showAlert(alertText: String) {
        let alertController = UIAlertController(title: "Error", message: alertText, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    
}

extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}
