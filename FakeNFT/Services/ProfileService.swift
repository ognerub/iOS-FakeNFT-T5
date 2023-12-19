//
//  ProfileService.swift
//  FakeNFT
//
//  Created by Aleksey Kolesnikov on 15.12.2023.
//

import Foundation

typealias ProfileCompletion = (Result<ProfileResult, Error>) -> Void

protocol ProfileServiceProtocol {
    func getProfile(completion: @escaping ProfileCompletion)
}

final class ProfileService: ProfileServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient, storage: ProfileStorage) {
        self.networkClient = networkClient
    }
    
    func getProfile(completion: @escaping ProfileCompletion) {
        let request = GetProfileRequest()
        networkClient.send(request: request, type: ProfileResult.self) { result in
            switch result {
                case .success(let profile):
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
