//
//  Constants.swift
//  InstagramSwiftUI
//
//  Created by Maciej on 17/11/2022.
//

import Firebase

let COLLECTION_POSTS = Firestore.firestore().collection("posts")
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_NOTIFICATIONS = Firestore.firestore().collection("notifications")
