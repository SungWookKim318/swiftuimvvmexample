//
//  MoviesListViewModel.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/02.
//

import Foundation
import SwiftUI


//struct MoviesListViewModelActions {
//    /// Note: if you would need to edit movie inside Details screen and update this Movies List screen with updated movie then you would need this closure:
//    /// showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
//    let showMovieDetails: (Movie) -> Void
//    let showMovieQueriesSuggestions: (@escaping (_ didSelect: MovieQuery) -> Void) -> Void
//    let closeMovieQueriesSuggestions: () -> Void
//}

enum MoviesListViewModelLoading {
    case fullScreen
    case nextPage
}

protocol MoviesListViewModelInput {
    func didSearch(query: String)
    func didSelect(at indexPath: IndexPath)
}

protocol MoviesListViewModelOutput: ObservableObject {
//    var items: Observable<[MoviesListItemViewModel]
    var item: [MoviesListItemViewModel] { get }
    var loading: MoviesListViewModelLoading { get set }
}

final class MoviesListViewModel: ObservableObject {
    private let searchMoviesUseCase: SearchMoviesUseCase?
//    private let actions: MoviesListViewModelAc
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { currentPage < totalPageCount }
    var nextPage: Int { hasMorePages ? (currentPage + 1) : currentPage }
    
    private var pages: [MoviesPage] = .init()
    private var moviesLoadTask: Cancellable? {
        willSet {
            moviesLoadTask?.cancel()
        }
    }
    
    // MARK: - OutPut
    @Published var items: [MoviesListItemViewModel] = .init()
    @Published var loading: MoviesListViewModelLoading?
    @Published var query: String?
    @Published var error: String?
    var isEmpty: Bool { return items.isEmpty }
    let screenTitle = "Movies"
    let emptyDataTitle = "Search results"
    let errorTitle = "Error"
    let searchBarPlaceholder = "Search Movies"
    
    init(searchMoviesUseCase: SearchMoviesUseCase) {
        self.searchMoviesUseCase = searchMoviesUseCase
    }
    
    private init() {
        self.searchMoviesUseCase = nil
    }
    
    // MARK: - Actions
    
    func requestSearch(query: String) {
        //resetPages()
        self.loading = .fullScreen
        self.query = query
        
        moviesLoadTask = searchMoviesUseCase?.exute(requestValue: .init(query: .init(query: query), page: nextPage), completion: { result in
            self.loading = .none
            switch result {
            case .success(let success):
//                self.appendPage
                return
            case .failure(let failure):
//                self.hand
                return
            }
        })
//        query
    }
    
    // MARK: - Test
    static func createDummy() -> MoviesListViewModel {
        let dummy = MoviesListViewModel()
        dummy.items = .init(repeating: .createDummy(), count: 5)
        return dummy
    }
}
