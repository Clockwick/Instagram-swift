//
//  Models.swift
//  Instagram
//
//  Created by Paratthakorn Sribunyong on 3/1/2564 BE.
//

import Foundation


enum Gender {
    case male, female, other
}
struct User {
    let username: String
    let name: (first:String, last:String)
    let profilePhoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
    let joinDate: Date
}

struct UserCount {
    let followers: Int
    let following: Int
    let posts: Int
}
public enum UserPostType {
    case photo, video
}


/// Represents a user post
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL // Either video url or full resolution photo
    let caption: String?
    let likeCount: [PostLike]
    let comments: [PostComment]
    let createdDate: Date
    let taggedUser: [String]
}

public struct PostLike {
    let username:String
    let postIdentifier: String
}
public struct CommentLike {
    let username:String
    let commentIdentifier: String
}
public struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createdDate: Date
    let likes: [CommentLike]
    
}
