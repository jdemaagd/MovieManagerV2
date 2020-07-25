//
//  WatchlistViewController.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class WatchlistViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - private methods
    
    var selectedIndex = 0
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.getWatchlist() { movies, error in
            MovieModel.watchlist = movies
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue" {
            let detailVC = segue.destination as! MovieDetailsViewController
            detailVC.movie = MovieModel.watchlist[selectedIndex]
        }
    }
}
