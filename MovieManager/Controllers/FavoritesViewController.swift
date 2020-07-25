//
//  FavoritesViewController.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - IBOulets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - variables
    
    var selectedIndex = 0
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Client.getFavorites() { movies, error in
            MovieModel.favorites = movies
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
            detailVC.movie = MovieModel.favorites[selectedIndex]
        }
    }
}
