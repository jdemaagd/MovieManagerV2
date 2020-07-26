//
//  MovieDetailsViewController.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var watchlistBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    
    
    // MARK: - variables
    
    var movie: Movie!
    
    var isWatchlist: Bool {
        return MovieModel.watchlist.contains(movie)
    }
    
    var isFavorite: Bool {
        return MovieModel.favorites.contains(movie)
    }
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = movie.title
        
        toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        
        if let posterPath = movie.posterPath {
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                self.imageView.image = image
            }
        }
    }
    
    
    // MARK: - private methods
    
    func handleFavoriteResponse(success: Bool, error: Error?) {
        if success {
            if isFavorite {
                MovieModel.favorites = MovieModel.favorites.filter() {
                    $0 != self.movie
                }
            } else {
                MovieModel.favorites.append(movie)
            }
            toggleBarButton(favoriteBarButtonItem, enabled: isFavorite)
        }
    }
    
    func handleWatchlistResponse(success: Bool, error: Error?) {
        if success {
            if isWatchlist {
                MovieModel.watchlist = MovieModel.watchlist.filter() {
                    $0 != self.movie
                }
            } else {
                MovieModel.watchlist.append(movie)
            }
            toggleBarButton(watchlistBarButtonItem, enabled: isWatchlist)
        }
    }
    
    func toggleBarButton(_ button: UIBarButtonItem, enabled: Bool) {
        if enabled {
            button.tintColor = UIColor.primaryDark
        } else {
            button.tintColor = UIColor.gray
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func watchlistButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markWatchlist(movieId: movie.id, watchlist: !isWatchlist, completion: handleWatchlistResponse(success:error:))
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIBarButtonItem) {
        TMDBClient.markFavorite(movieId: movie.id, favorite: !isFavorite, completion: handleFavoriteResponse(success:error:))
    }
}
