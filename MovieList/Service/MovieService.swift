//
//  MovieService.swift
//  MovieList
//
//  Created by Sehmus GOKCE on 9.05.2019.
//  Copyright © 2019 Sehmus GOKCE. All rights reserved.
//

import Foundation
import Alamofire

public class MovieService : NSObject {
    public static func getPopularMovies(language : String? = nil, page: Int, completionHandler: @escaping (MovieResultModel?, String?) -> Void) {
        
        
        //Prepare Parameters for Service Call
        var parameters : [String:Any] = [:]
        
        parameters["page"] = page
        parameters["api_key"] = Constants.Service.apiKey
        
        if language != nil {
            parameters["language"] = language
        }
        else
        {
            let langStr = Locale.current.languageCode! + "-" + Locale.current.regionCode!
            parameters["language"] = langStr
        }
        
        Alamofire.request(Constants.Service.baseUrl + Constants.Service.popularMovies,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding(destination: .queryString)).validate(statusCode: 200..<300).responseData { response in
                            switch response.result{
                            case .success:
                                let decoder = JSONDecoder()
                                let vehicleData = try? decoder.decode(MovieResultModel.self, from: response.result.value!)
                                completionHandler(vehicleData, nil)
                                break
                            case .failure(let error):
                                completionHandler(nil, error.localizedDescription)
                                break
                            }
        }
    }
}
