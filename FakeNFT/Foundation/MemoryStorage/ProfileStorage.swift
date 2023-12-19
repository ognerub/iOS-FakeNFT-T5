//
//  ProfileStorage.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 15.12.2023.
//

import Foundation

protocol ProfileStorage: AnyObject {
    func saveProfile(_ profile: ProfileModel)
    func getProfile(id: String) -> ProfileModel?
}

final class ProfileStorageImpl: ProfileStorage {
    private var storage: [String:ProfileModel] = [:]
    
    private let syncQueue = DispatchQueue(label: "sync-profile-queue")
    
    func saveProfile(_ profile: ProfileModel) {
        syncQueue.async { [weak self] in
            self?.storage[profile.id] = profile
        }
    }
    
    func getProfile(id: String) -> ProfileModel? {
        syncQueue.sync {
            storage[id]
        }
    }
}
