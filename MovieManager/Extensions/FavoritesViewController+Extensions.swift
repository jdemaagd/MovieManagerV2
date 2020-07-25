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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")!
        
        let movie = MovieModel.favorites[indexPath.row]
        
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "showDetailsSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
