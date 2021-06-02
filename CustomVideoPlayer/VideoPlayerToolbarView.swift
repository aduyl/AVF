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
    
    lazy var fastForvardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(systemName: "forward"), for: .normal)
        return button
    }()
    
    lazy var rewindButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.init(systemName: "backward"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(playButton)
        addSubview(fastForvardButton)
        addSubview(rewindButton)
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playButton.frame = CGRect(x: bounds.width / 3, y: 0.0, width: bounds.width / 3, height: bounds.height)
        fastForvardButton.frame = CGRect(x: bounds.width * 2 / 3, y: 0.0, width: bounds.width / 3, height: bounds.height)
        rewindButton.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width / 3, height: bounds.height)
    }
    
}
