//
//  PostController.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import UIKit

class PostController {
    static let baseURL = URL(string: "https://www.reddit.com/")
    static let rComponent = "r"
    static let jsonExtension = "json"


//https://www.reddit.com/r/funny.json
    
    static func fetchPosts(with searchTerm: String, completion: @escaping (Result<[Post], PostError>) -> Void) {
        // URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let rURL = baseURL.appendingPathComponent(rComponent)
        let searchURL = rURL.appendingPathComponent(searchTerm)
        let finalURL = searchURL.appendingPathExtension(jsonExtension)
        
        print(finalURL)
        
        // Data task
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            // Error Handling
            if let error = error {
                print("URLSession Error", error, error.localizedDescription)
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode != 200 {
                    print("POST STATUS CODE: \(response.statusCode)")
                }
            }
            
            // Data check
            guard let data = data else {
                print("No data")
                return completion(.failure(.noData))
            }
            
            // Data decode
            do {
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                let thirdLevelObject = topLevelObject.data.children
                var arrayOfPosts: [Post] = []
                
                for dict in thirdLevelObject {
                    let post = dict.data
                    arrayOfPosts.append(post)
                }
                
                return completion(.success(arrayOfPosts))
            } catch {
                print("Unable to decode data")
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    
    static func fetchThumbnail(for post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void ) {
        
        guard let thumbnailURL = URL(string: post.thumbnail) else {
            return completion(.failure(.invalidURL))
        }
        
        URLSession.shared.dataTask(with: thumbnailURL) { data, _, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode)) }
            completion(.success(thumbnail))
        }.resume()
    }
} // End of class
