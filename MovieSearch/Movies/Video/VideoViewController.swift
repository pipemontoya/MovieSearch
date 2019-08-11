//
//  VideoViewController.swift
//  MovieSearch
//
//  Created by Andres Montoya on 8/11/19.
//  Copyright © 2019 Andres Montoya. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class VideoViewController: UIViewController {
    
    var key: String?
    @IBOutlet weak var videoView: WKYTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoView.contentMode = .scaleAspectFit
        videoView.load(withVideoId: key ?? "")
        videoView.delegate = self
    }

    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func closeGesture(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension VideoViewController: WKYTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: WKYTPlayerView) {
        videoView.playVideo()
    }
}
