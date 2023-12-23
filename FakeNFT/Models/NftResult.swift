//
//  NftResult.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 20.12.2023.
//

import Foundation

public struct NftResult: Decodable {
    let createdAt: String
    let name: String
    let images: [String]
    let rating: Int
    let description: String?
    let price: Float
    let author: String
    let id: String
}
