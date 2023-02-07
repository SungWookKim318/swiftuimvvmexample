//
//  MoviesListViewModel.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/02.
//

import Foundation
import SwiftUI


struct MoviesListViewModelActions {
    /// Note: if you would need to edit movie inside Details screen and update this Movies List screen with updated movie then you would need this closure:
    /// showMovieDetails: (Movie, @escaping (_ updated: Movie) -> Void) -> Void
    let showMovieDetails: (Movie) -> MovieDetailView
    let showMovieQueriesSuggestions: (@escaping (_ didSelect: MovieQuery) -> Void) -> Void
    let closeMovieQueriesSuggestions: () -> Void
}

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
    private let actions: MoviesListViewModelActions?
    
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
    
    @Published var detailView: MovieDetailView?
    
    var isEmpty: Bool { return items.isEmpty }
    let screenTitle = "Movies"
    let emptyDataTitle = "Search results"
    let errorTitle = "Error"
    let searchBarPlaceholder = "Search Movies"
    
    init(searchMoviesUseCase: SearchMoviesUseCase, actions: MoviesListViewModelActions) {
        self.searchMoviesUseCase = searchMoviesUseCase
        self.actions = actions
    }
    
    private init() {
        self.searchMoviesUseCase = nil
        self.actions = nil
    }
    
    // MARK: - Actions
    
    func requestSearch(query: String) {
        //resetPages()
        self.loading = .fullScreen
        self.query = query
        
        moviesLoadTask = searchMoviesUseCase?.exute(requestValue: .init(query: .init(query: query), page: nextPage), completion: { result in
            switch result {
            case .success(let pages):
                print("Success to get movie pages")
                self.appendPage(pages: pages)
            case .failure(let failure):
                print("fail to get movie pages \(failure)")
            }
            self.loading = .none
        })
    }
    
    func selectMovie(item: MoviesListItemViewModel) {
        guard let movie = pages.flatMap({$0.movies}).first(where: { $0.id == item.id}) else {
            print("unkown item")
            return
        }
        detailView = actions?.showMovieDetails(movie)
    }
    
    // MARK: - Test
    static func createDummy() -> MoviesListViewModel {
        let dummy = MoviesListViewModel()
        dummy.items = .init(repeating: .createDummy(), count: 5)
        return dummy
    }
    
    
    // MARK: - Helper
    private func appendPage(pages: MoviesPage) {
        currentPage = pages.page
        totalPageCount = pages.totalPages
        
        self.pages = self.pages.filter { $0.page != pages.page }
            + [pages]
        
        items = pages.movies.map(MoviesListItemViewModel.init)
    }
}
