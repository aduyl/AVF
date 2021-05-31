//
//  Video.swift
//  AVFoundationSwift
//
//  Created by mac on 30.05.2021.
//

import Foundation
class Video: NSObject {
    var url: URL
    
    init(url: URL){
        self.url = url
        super.init()
    }
    
    var saveVideo: Video?
}




