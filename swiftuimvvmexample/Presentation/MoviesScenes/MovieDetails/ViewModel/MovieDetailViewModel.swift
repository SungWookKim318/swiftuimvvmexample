//
//  MovieDetailViewModel.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/06.
//

import Foundation

struct MovieDetailViewModelActions {
    
}

class MovieDetailViewModel: ObservableObject {
//    private let actions: MovieDetailViewModelActions?
    @Published var title: String
    @Published var isImageHidden: Bool
    @Published var imagePath: String?
    @Published var information: String
    
    init(title: String, isImageHidden: Bool = false, imagePath: String? = nil, information: String) {
        self.title = title
        self.isImageHidden = isImageHidden
        self.imagePath = imagePath
        self.information = information
    }
    
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.information = movie.overview ?? ""
        self.imagePath = movie.posterPath
        self.isImageHidden = movie.posterPath == nil
    }
    
    static func createDummy() -> MovieDetailViewModel {
        return .init(title: "Test Item", isImageHidden: false, imagePath: nil, information: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.")
    }
}
