//
//  VideoPlayerToolbarView.swift
//  AVFoundationSwift
//
//  Created by g.sukhorukov on 31.05.2021.
//

import UIKit

class VideoPlayerToolbarView: UIView {
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(systemName: "play"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(playButton)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
    }
    
}
