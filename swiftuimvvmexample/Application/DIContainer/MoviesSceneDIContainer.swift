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
        let apiDataTransferService: DataTransferService
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
        return DefaultMoviesRepository(dataTransferService: dependecies.apiDataTransferService, cache: moviesResponseCache)
    }
    
    // MARK: - Generate ViewModel
        
    private func makeMoviesListViewModel(actions: MoviesListViewModelActions) -> MoviesListViewModel {
        return .init(searchMoviesUseCase: makeSearchMoviesUseCase(), actions: actions)
    }
    
    private func makeMovieDetailViewModel(movie: Movie) -> MovieDetailViewModel {
        return .init(movie: movie)
    }
    
    // MARK: - Flow Coordinators
    func makeMovieSearchFlowCoordinator() -> MoviesSearchFlowCoordinator {
        return MoviesSearchFlowCoordinator(dependencies: self)
    }
}

extension MoviesSceneDIContainer: MoviesSearchFlowCoordinatorDependencies {
    func makeMoviesListMainView(actions: MoviesListViewModelActions) -> MoviesListMainView {
        return MoviesListMainView(moviesListViewModel: makeMoviesListViewModel(actions: actions))
    }
    
    func makeMovieDetailView(movie: Movie) -> MovieDetailView {
        return MovieDetailView(detailViewModel: makeMovieDetailViewModel(movie: movie))
    }
}
