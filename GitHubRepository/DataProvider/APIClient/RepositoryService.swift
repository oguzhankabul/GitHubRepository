//
//  Service.swift
//  GitHubRepository
//
//  Created by Oğuzhan Kabul on 15.04.2023.
//

import Foundation

final class Service {
    
    static let shared = Service()
    
    private init() {}
    
    private enum RepositoryServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
    }
    
    public func execute<T: Codable>( _ request: RepositoryRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RepositoryServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? RepositoryServiceError.failedToGetData))
                return
            }
            
            do {
                let result = try SnakeCaseJSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    private func request(from repositoryRequest: RepositoryRequest) -> URLRequest? {
        guard let url = repositoryRequest.url else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = repositoryRequest.httpMethod
        return request
    }
}
