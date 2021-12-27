//
//  GenreDataSource.swift
//  RandomMovieSelector
//
//  Created by Özgün Irmak on 27.12.2021.
//

import Foundation

class GenreDataSource
{
    private var genresList: [Genre] = []
    var delegate: GenreDataSourceDelegate?
    
    func getNumberOfGenres() -> Int
    {
        return genresList.count
    }
    
    func getGenreForIndex(index: Int) -> Genre
    {
        let realIndex = index % genresList.count
        return genresList[realIndex]
    }
    
    func loadGenreList()
    {
        let headers = [
            "x-rapidapi-host": "advanced-movie-search.p.rapidapi.com",
            "x-rapidapi-key": "36244593ffmsh1964da33c0872e6p1451bdjsn16520b32f67b"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://advanced-movie-search.p.rapidapi.com/genre/movie/list")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            if let data = data
            {
                let decoder = JSONDecoder()
                let genreArrayFromNetwork = try! decoder.decode([Genre].self, from: data)
                self.genresList = genreArrayFromNetwork
                DispatchQueue.main.async
                {
                    self.delegate?.genreListLoaded()
                }
            }
        })

        dataTask.resume()
    }
    
}
