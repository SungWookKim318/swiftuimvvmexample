//
//  MoviesResponseStorage.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation

protocol MoviesResponseStorage {
    func getResponse(for request: MoviesRequestDTO, completion: @escaping (Result<MoviesResponseDTO?, CoreDataStorageError>) -> Void)
    func save(response: MoviesResponseDTO, for requestDto: MoviesRequestDTO)
}
