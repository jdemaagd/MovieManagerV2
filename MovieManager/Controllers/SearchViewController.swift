//
//  SearchViewController.swift
//  MovieManager
//
//  Created by JON DEMAAGD on 7/22/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - variables
    
    var movies = [Movie]()
    var selectedIndex = 0
    var currentSearchTask: URLSessionDataTask?
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsSegue" {
            let detailVC = segue.destination as! MovieDetailsViewController
            detailVC.movie = movies[selectedIndex]
        }
    }
}
