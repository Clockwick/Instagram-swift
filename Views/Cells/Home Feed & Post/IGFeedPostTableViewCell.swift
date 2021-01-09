//
//  IGFeedPostTableViewCell.swift
//  Instagram
//
//  Created by Paratthakorn Sribunyong on 2/1/2564 BE.
//
import SDWebImage
import AVFoundation
import UIKit

/// Cell for primary post content
final class IGFeedPostTableViewCell: UITableViewCell {
    
    static let identifier = "IGFeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var player: AVPlayer?
    private var playerLayer = AVPlayerLayer()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer)
        contentView.addSubview(postImageView)
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "test")
        // Configure the cell
        return
        switch post.postType {
        case .photo:
            // Show image
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            // Load and play video
            player = AVPlayer(url: post.postURL)
            playerLayer.player = player
            playerLayer.player?.volume = 0
            playerLayer.player?.play()
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        playerLayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        
    }

}
