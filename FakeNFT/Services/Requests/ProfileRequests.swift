//
//  ProfileRequests.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 15.12.2023.
//

import Foundation

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
}

struct PutProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/api/v1/profile/1")
    }
    var httpMethod = HttpMethod.put
    var dto: Encodable? {
        profileDto
    }
    let profileDto: ProfileDto
    
    init(profile: ProfileUpdate) {
        profileDto = ProfileDto(from: profile)
    }
}
