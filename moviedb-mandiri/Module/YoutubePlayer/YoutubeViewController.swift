//
//  YoutubeViewController.swift
//  moviedb-mandiri
//
//  Created by Calvin Saragih on 19/07/20.
//  Copyright © 2020 Calvin. All rights reserved.
//

import UIKit
import youtube_ios_player_helper
class YoutubeViewController: UIViewController {

    var urlYoutube:String?
    @IBOutlet weak var videoPlayer: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let id = urlYoutube?.replacingOccurrences(of: "https://www.youtube.com/watch?v=", with: "") ?? ""
              videoPlayer.delegate = self
              videoPlayer.load(withVideoId: id)
    }
    

}

extension YoutubeViewController:YTPlayerViewDelegate{
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        videoPlayer.playVideo()
    }
}
