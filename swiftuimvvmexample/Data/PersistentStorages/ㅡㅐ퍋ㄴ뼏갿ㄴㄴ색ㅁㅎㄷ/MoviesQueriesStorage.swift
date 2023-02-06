//
//  MoviesQueriesStorage.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation

protocol MoviesQueriesStorage {
    func fetchRecentsQueries(maxCount: Int, completion: @escaping (Result<[MovieQuery], Error>) -> Void)
    func saveRecentQuery(query: MovieQuery, completion: @escaping (Result<MovieQuery, Error>) -> Void)
}
