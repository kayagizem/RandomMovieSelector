//
//  MoviesViewController.swift
//  RandomMovieSelector
//
//  Created by gizem.kaya on 26.12.2021.
//

import UIKit

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var MoviesCollection: UICollectionView!
    var selectedCategory: String? = "unknown"
    let movieDataSource = MovieData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        movieDataSource.loadMovieList(category: selectedCategory!)
        movieDataSource.delegate = self
        self.title = "Movies of \(String(describing: selectedCategory))"

    }
    override func viewWillAppear(_ animated: Bool) {
        if let movieCategory = selectedCategory{
            movieDataSource.loadMovieList(category: movieCategory)
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}

extension MoviesViewController: MovieDataDelegate{
    func CategoryListLoaded() {
        
    }
    
    func MovieListLoaded() {
        MoviesCollection.reloadData()
    }
    
    func MovieDetailLoaded() {
        
    }
    
}

extension MoviesViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDataSource.getNumberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movieDataSource.getMovieForIndex(index: indexPath.row)
        cell.MovieLabel.text = movie.Series_Title
        return cell
    }
}
