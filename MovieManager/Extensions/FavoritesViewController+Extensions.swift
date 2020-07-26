//
//  FavoritesViewController+Extensions.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/23/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit


// MARK: - TableView delegate methods

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = MovieModel.favorites[indexPath.row]
        
        cell.textLabel?.text = movie.title
        if let posterPath = movie.posterPath {
            TMDBClient.downloadPosterImage(path: posterPath) { (data, error) in
                guard let data = data else {
                    return
                }
                let image = UIImage(data: data)
                cell.imageView?.image = image
                cell.setNeedsLayout()   // refresh cells
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetailsSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
