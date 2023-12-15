import Foundation

typealias NftCompletionTest = (Result<Nft, Error>) -> Void

protocol NftServiceTest {
    func loadNftTest(id: String, completion: @escaping NftCompletionTest)
}

final class NftServiceImplTest: NftServiceTest {

    private let networkClient: NetworkClient
    private let storage: NftStorageTest

    init(networkClient: NetworkClient, storage: NftStorageTest) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNftTest(id: String, completion: @escaping NftCompletionTest) {
        if let nft = storage.getNft(with: id) {
            completion(.success(nft))
            return
        }

        let request = NFTRequestTest(id: id)
        networkClient.send(request: request, type: Nft.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveNft(nft)
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
