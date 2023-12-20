//
//  ProfileDto.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 19.12.2023.
//

import Foundation

struct ProfileDto: Encodable {
    let name: String
    let description: String
    let website: String
    let likes: [String]
    
    init(from profile: ProfileUpdate) {
        self.name = profile.name
        self.description = profile.description
        self.website = profile.website
        self.likes = profile.likes
    }
}
