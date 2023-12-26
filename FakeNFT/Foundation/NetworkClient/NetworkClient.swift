import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
}

protocol NetworkClient {
    @discardableResult
    func send(request: NetworkRequest,
              completionQueue: DispatchQueue,
              onResponse: @escaping (Result<Data, Error>) -> Void) -> NetworkTask?

    @discardableResult
    func send<T: Decodable>(request: NetworkRequest,
                            type: T.Type,
                            completionQueue: DispatchQueue,
                            onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask?
}

extension NetworkClient {

    @discardableResult
    func send(request: NetworkRequest,
              onResponse: @escaping (Result<Data, Error>) -> Void) -> NetworkTask? {
        send(request: request, completionQueue: .main, onResponse: onResponse)
    }

    @discardableResult
    func send<T: Decodable>(request: NetworkRequest,
                            type: T.Type,
                            onResponse: @escaping (Result<T, Error>) -> Void) -> NetworkTask? {
        send(request: request, type: type, completionQueue: .main, onResponse: onResponse)
    }
}

struct DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(session: URLSession = URLSession.shared,
         decoder: JSONDecoder = JSONDecoder(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }

    @discardableResult
    func send(
        request: NetworkRequest,
        completionQueue: DispatchQueue,
        onResponse: @escaping (Result<Data, Error>) -> Void
    ) -> NetworkTask? {
        let onResponse: (Result<Data, Error>) -> Void = { result in
            completionQueue.async {
                onResponse(result)
            }
        }
        guard let urlRequest = create(request: request) else { return nil }

        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                onResponse(.failure(NetworkClientError.urlSessionError))
                return
            }

            guard 200 ..< 300 ~= response.statusCode else {
                onResponse(.failure(NetworkClientError.httpStatusCode(response.statusCode)))
                return
            }

            if let data = data {
                onResponse(.success(data))
                return
            } else if let error = error {
                onResponse(.failure(NetworkClientError.urlRequestError(error)))
                return
            } else {
                assertionFailure("Unexpected condition!")
                return
            }
        }

        task.resume()

        return DefaultNetworkTask(dataTask: task)
    }

    @discardableResult
    func send<T: Decodable>(
        request: NetworkRequest,
        type: T.Type,
        completionQueue: DispatchQueue,
        onResponse: @escaping (Result<T, Error>) -> Void
    ) -> NetworkTask? {
        return send(request: request, completionQueue: completionQueue) { result in
            switch result {
            case let .success(data):
                self.parse(data: data, type: type, onResponse: onResponse)
            case let .failure(error):
                onResponse(.failure(error))
            }
        }
    }

    // MARK: - Private
    
    private enum NetworkConstants {
        static let putValue = "application/x-www-form-urlencoded"
        static let putHeader = "Content-Type"
        static let connectionValue = "Keep-alive"
        static let connectionHeader = "Connection"
        static let acceptValue = "application/json"
        static let acceptHeader = "Accept"
        static let acceptEncodingValue = "gzip, deflate, br"
        static let acceptEncodingHeader = "Accept-Encoding"
        static let tokenValue = "a66690d9-233c-4541-a539-179c0a04d8da"
        static let tokenHeader = "X-Practicum-Mobile-Token"
    }
    
    private func create(request: NetworkRequest) -> URLRequest? {
        guard let endpoint = request.endpoint else {
            assertionFailure("Empty endpoint")
            return nil
        }

        var urlRequest = URLRequest(url: endpoint)
        
        urlRequest.httpMethod = request.httpMethod.rawValue        
        
        if urlRequest.httpMethod == HttpMethod.put.rawValue {
            urlRequest.setValue(NetworkConstants.putValue, forHTTPHeaderField: NetworkConstants.putHeader)
            if let body = request.body {
                urlRequest.httpBody = body
            }
        }
        
        urlRequest.setValue(NetworkConstants.connectionValue, forHTTPHeaderField: NetworkConstants.connectionHeader)
        urlRequest.setValue(NetworkConstants.acceptValue, forHTTPHeaderField: NetworkConstants.acceptHeader)
        urlRequest.setValue(NetworkConstants.acceptEncodingValue, forHTTPHeaderField: NetworkConstants.acceptEncodingHeader)
        
        urlRequest.setValue(NetworkConstants.tokenValue, forHTTPHeaderField: NetworkConstants.tokenHeader)

        return urlRequest
    }

    private func parse<T: Decodable>(data: Data, type _: T.Type, onResponse: @escaping (Result<T, Error>) -> Void) {
        do {
            let response = try decoder.decode(T.self, from: data)
            onResponse(.success(response))
        } catch {
            onResponse(.failure(NetworkClientError.parsingError))
        }
    }
}
