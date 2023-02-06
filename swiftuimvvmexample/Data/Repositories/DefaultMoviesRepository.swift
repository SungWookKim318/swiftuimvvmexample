//
//  DefaultMoviesRepository.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation

final class DefaultMoviesRepository {
    private let dataTransferService: DataTransferService
    private let cache: MoviesResponseStorage
    
    init(dataTransferService: DataTransferService, cache: MoviesResponseStorage) {
        self.dataTransferService = dataTransferService
        self.cache = cache
    }
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchMoviesList(query: MovieQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable? {
        let requestDTO = MoviesRequestDTO(query: query.query, page: page)
        let task = RepositoryTask()
        
        cache.getResponse(for: requestDTO) { result in
            guard !task.isCancelled else { return }
            
            let endpoint = APIEndpoints.getMovies(with: requestDTO)
            task.networkTask = self.dataTransferService.request(with: endpoint, completion: { result in
                switch result {
                case .success(let responseDTO):
                    self.cache.save(response: responseDTO, for: requestDTO)
                    completion(.success(responseDTO.toDomain()))
                case .failure(let error):
                    completion(.failure(error))
                }
            })
        }
        return task
    }
}
