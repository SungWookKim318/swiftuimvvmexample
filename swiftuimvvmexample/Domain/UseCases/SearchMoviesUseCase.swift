//
//  SearchMoviesUseCase.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/02.
//

import Foundation

struct SearchMoviesUseCaseRequestValue {
  let query: MovieQuery
  let page: Int
}

protocol SearchMoviesUseCase {
    func exute(requestValue: SearchMoviesUseCaseRequestValue, completion: @escaping ((Result<MoviesPage, Error>) -> Void)) -> Cancellable?
}

final class DefaultSearchMoviesUseCase: SearchMoviesUseCase {
    private let moviesRepository: MoviesRepository
//    private let moviesQueriesRepository: MoviesQueriesRepository
    
//    init(moviesRepository: MoviesRepository, moviesQueriesRepository: MoviesQueriesRepository)
    init(moviesRepository: MoviesRepository) {
        self.moviesRepository = moviesRepository
    }
    
    func exute(requestValue: SearchMoviesUseCaseRequestValue, completion: @escaping ((Result<MoviesPage, Error>) -> Void)) -> Cancellable? {
        return moviesRepository.fetchMoviesList(query: requestValue.query, page: requestValue.page) { result in
//            if case .success = result {
//                self.moviesQueriesRepository.saveRecentQuery(query: requestValue.query) { _ in }
//            }
            completion(result)
        }
    }
}

// Repository Interfaces
protocol MoviesRepository {
    func fetchMoviesList(query: MovieQuery, page: Int, completion: @escaping (Result<MoviesPage, Error>) -> Void) -> Cancellable?
}

protocol MoviesQueriesRepository {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[MovieQuery], Error>) -> Void)
    func saveRecentQuery(query: MovieQuery, completion: @escaping (Result<MovieQuery, Error>) -> Void)
}
