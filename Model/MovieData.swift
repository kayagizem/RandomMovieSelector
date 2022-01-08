//
//  MovieData.swift
//  RandomMovieSelector
//
//  Created by gizem.kaya on 2.01.2022.
//

import FirebaseDatabase
import Foundation

class MovieData
{
    private let database = Database.database().reference()
    var databaseRef: DatabaseReference?
    var delegate: MovieDataDelegate?
    private var movieList: [Movie] = []
    private var categoryList: [String] = []
    
    var movies = [Movie]()
    
    init()  {

    }
    
    func getNumberOfMovies() -> Int {
        return movieList.count
    }
    
    func getNumberOfCategories() -> Int {
        return categoryList.count
    }
    
    func getMovieForIndex(index: Int) -> Movie {
        let realIndex = index % movieList.count
        return movieList[realIndex]
    }
    func getCategoryForIndex(index: Int) -> String {
        let realIndex = index % categoryList.count
        return categoryList[realIndex]
    }
    
    func loadMovieList(category: String)
    
    {
        databaseRef = Database.database().reference()
        databaseRef?.observe(.childAdded){ [weak self] (snapshot) in
            let key = snapshot.key
            guard let value  = snapshot.value as? [String: Any] else {return}
            
            if let certificate = value["Certificate"] as? String,
               let director = value["Director"] as? String,
               let genre = value["Genre"] as? String,
               let gross = value["Gross"] as? String,
               let IMDBRating = value["IMDB_Rating"] as? Double,
               let MetaScore = value["Meta_score"] as? Int,
               let noOfVotes = value["No_of_Votes"] as? Int,
               let posterLink = value["Poster_Link"] as? String,
               let overview = value["Overview"] as? String,
               let releasedYear = value["Released_Year"] as? Int,
               let runtime = value["Runtime"] as? String,
               let seriesTitle = value["Series_Title"] as? String,
               let star1 = value["Star1"] as? String,
               let star2 = value["Star2"] as? String,
               let star3 = value["Star3"] as? String,
               let star4 = value["Star4"] as? String
            {
                let movie = Movie(movieId: key, Certificate: certificate, Director: director, Genre: genre, Gross: gross, IMDB_Rating: IMDBRating, Meta_score: MetaScore, No_of_Votes: noOfVotes, Overview: overview, Poster_Link: posterLink, Released_Year: releasedYear, Runtime: runtime, Series_Title: seriesTitle, Star1: star1, Star2: star2, Star3: star3, Star4: star4)
                
                self?.movies.append(movie)
                DispatchQueue.main.async {
                    self!.delegate?.MovieListLoaded()
                }
                print(movie)
                /* if let row = self?.movies.count{
                 let indexPath = IndexPath(row: row-1, section: 0)
                 self?.movieList.insertRows(at: [IndexPath], with: .automatic)
                 }*/
            }
        }
    }
    
    func loadCategoryList(){
        categoryList.append("Action")
        categoryList.append("Adventure")
        categoryList.append("Animation")
        categoryList.append("Biography")
        categoryList.append("Comedy")
        categoryList.append("Crime")
        categoryList.append("Documentary")
        categoryList.append("Drama")
        categoryList.append("Family")
        categoryList.append("Fantasy")
        categoryList.append("Film-Noir")
        categoryList.append("History")
        categoryList.append("Horror")
        categoryList.append("Music")
        categoryList.append("Musical")
        categoryList.append("Mystery")
        categoryList.append("Romance")
        categoryList.append("Sci-Fi")
        categoryList.append("Short Film")
        categoryList.append("Sport")
        categoryList.append("Superhero")
        categoryList.append("Thriller")
        categoryList.append("War")
        categoryList.append("Western")

        DispatchQueue.main.async {
            self.delegate?.CategoryListLoaded()
        }
    }
    
    
    
    func getDirector(randomIndex: Int)
    {
        database.child("\(randomIndex)").child("Director").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? String else {
                return
            }
            print(value)
        })
    }
    
    
    func getGenre (randomIndex: Int)
    {
        database.child("\(randomIndex)").child("Genre").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? String else {
                return
            }
            print(value)
        })
    }
    
    func getIMDBRating(randomIndex: Int)
    {
        
        database.child("\(randomIndex)").child("IMDB_Rating").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? String else {
                return
            }
            print(value)
        })
        
    }
    
    func getOverview(randomIndex: Int)
    {
        
    }
    
    
    
    func getPosterLink(randomIndex: Int)
    {
        
        
    }
    
}



