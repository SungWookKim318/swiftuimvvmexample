//
//  MoviesSearchFlowCoordinator.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation
import SwiftUI

protocol MoviesSearchFlowCoordinatorDependencies {
    func makeMoviesListMainView(actions: MoviesListViewModelActions) -> MoviesListMainView
    func makeMovieDetailView(movie: Movie) -> MovieDetailView
}

final class MoviesSearchFlowCoordinator {
    private let dependencies: MoviesSearchFlowCoordinatorDependencies
    
    init(dependencies: MoviesSearchFlowCoordinatorDependencies) {
        self.dependencies = dependencies
    }
    
    func makeStartView() -> some View {
        return makeListView()
    }
    
    private func makeListView() -> some View {
        let action = MoviesListViewModelActions(showMovieDetails: self.showMovieDetails(movie:), showMovieQueriesSuggestions: self.showMovieQueriesSuggestions(didSelect:), closeMovieQueriesSuggestions: self.closeMovieQueriesSuggestions)
        return dependencies.makeMoviesListMainView(actions: action)
    }
    
    private func showMovieDetails(movie: Movie) -> MovieDetailView {
        return dependencies.makeMovieDetailView(movie: movie)
    }
    
    private func showMovieQueriesSuggestions(didSelect: @escaping (MovieQuery) -> Void) {
        
    }
    
    private func closeMovieQueriesSuggestions() {
        
    }
}
