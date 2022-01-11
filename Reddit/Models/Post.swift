//
//  Post.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import Foundation

// Root
struct TopLevelObject : Decodable {
    let data: SecondLevelObject
}

// data
struct SecondLevelObject : Decodable {
    let children: [ThirdLevelObject]
}

// children
struct ThirdLevelObject : Decodable {
    let data: Post
}

// Index __
struct Post : Decodable {
    let title: String
    let ups: Int
    let thumbnail: String
}
