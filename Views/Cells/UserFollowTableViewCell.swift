//
//  UserFollowTableViewCell.swift
//  Instagram
//
//  Created by Paratthakorn Sribunyong on 3/1/2564 BE.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserRelationship)
        
}

enum FollowState {
    case following // Indicates the current user is following the other user
    case not_following // Indicates the current is not following the other user
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}
class UserFollowTableViewCell: UITableViewCell {
    static let identifier = "UserFollowTableViewCell"

    public weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "Joe"
        return label
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "@Joe"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLabel)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(followButton)
        contentView.addSubview(profileImageView)
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model:UserRelationship) {
        self.model = model
        nameLabel.text = model.name
        userNameLabel.text = model.username
        switch (model.type) {
        case .following:
            // Show unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor
            
        case .not_following:
            // Show follow button
            followButton.setTitle("Follow", for:.normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLabel.text = nil
        userNameLabel.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2.0
        
        let buttonWidth = contentView.width > 500 ? 220.0 : contentView.width / 3
        followButton.frame = CGRect(x: contentView.width - 5 - buttonWidth, y: (contentView.height - 40)/2, width: buttonWidth, height: 40)
        let labelHeight = contentView.height / 2
        nameLabel.frame = CGRect(x: profileImageView.right + 5, y: 0, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        userNameLabel.frame = CGRect(x: profileImageView.right + 5, y: nameLabel.bottom, width: contentView.width - 8 - profileImageView.width - buttonWidth, height: labelHeight)
        
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }

}
