//
//  MoviesListItemViewModel.swift
//  swiftuimvvmexample
//
//  Created by FitnessCandy on 2023/02/02.
//

import Foundation

struct MoviesListItemViewModel: Equatable, Hashable {
    let title: String
    let overview: String
    let releaseDate: String
    let posterImagePath: String?
    
    static func createDummy() -> MoviesListItemViewModel {
            return MoviesListItemViewModel(title: "Test Title", overview: "OverView OverView", releaseDate: "2019-09-08", posterImagePath: nil)
    }
}

extension MoviesListItemViewModel {
    init(movie: Movie) {
        self.title = movie.title ?? ""
        self.posterImagePath = movie.posterPath
        self.overview = movie.overview ?? ""
        if let releaseDate = movie.releaseDate {
            self.releaseDate = "\(NSLocalizedString("Release Date", comment: "")): \(dateFormatter.string(from: releaseDate))"
        } else {
            self.releaseDate = NSLocalizedString("To be announced", comment: "")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()
