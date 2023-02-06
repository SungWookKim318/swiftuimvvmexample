//
//  MoviesSceneDIContainer.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation
import SwiftUI

final class MoviesSceneDIContainer {
    struct Dependencies {
        let apiDataTransferSeverice: DataTransferService
        let imageDataTransferService: DataTransferService
    }
    
    private let dependecies: Dependencies
    
    // MARK: - Persistent Storage
//    lazy var moviesQueriesStorage: MoviesQueriesStorage = CoreDataMoviesQueriesStorage(maxStorageLimit: 10)
    lazy var moviesResponseCache: MoviesResponseStorage = CoreDataMoviesResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependecies = dependencies
    }
    
    func makeSearchMoviesUseCase() -> SearchMoviesUseCase {
        return DefaultSearchMoviesUseCase(moviesRepository: makeMoviesRepository())
    }
    
    // MARK: - Repositories
    func makeMoviesRepository() -> MoviesRepository {
        return DefaultMoviesRepository(dataTransferService: dependecies.apiDataTransferSeverice, cache: moviesResponseCache)
    }
    
    func makeMoviesListView(actions: MoviesListViewModelActions) -> MoviesListView {
        
    }
    
    private func makeMoviesListViewModel(actions: MoviesListViewModelAction) -> MoviesListViewModel {
        return .init(searchMoviesUseCase: makeSearchMoviesUseCase(), actions: actions)
    }
}
