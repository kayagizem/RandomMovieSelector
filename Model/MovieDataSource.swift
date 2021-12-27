//
//  MovieDataSource.swift
//  RandomMovieSelector
//  Created by Özgün Irmak on 27.12.2021.
//

import Foundation

class MovieDataSource
{
    private var movieList: [Movie] = []
    var delegate: MovieDataSourceDelegate?
    
    func getNumberOfMovies() -> Int
    {
        return movieList.count
    }
    
    func getMovieForIndex(index: Int) -> Movie
    {
        let realIndex = index % movieList.count
        return movieList[realIndex]
    }
    
    func loadMovieList()
    {
        let headers = [
            "x-rapidapi-host": "advanced-movie-search.p.rapidapi.com",
            "x-rapidapi-key": "36244593ffmsh1964da33c0872e6p1451bdjsn16520b32f67b"
        ]
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://advanced-movie-search.p.rapidapi.com/discover/movie?with_genres=36")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let data = data
            {
                let decoder = JSONDecoder()
                let movieListArrayFromNetwork = try! decoder.decode([Movie].self, from: data)
                self.movieList = movieListArrayFromNetwork
                DispatchQueue.main.async
                {
                    self.delegate?.movieListLoaded()
                }
            }
        })
        
        dataTask.resume()
        
    }
}
