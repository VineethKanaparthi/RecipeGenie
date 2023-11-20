//
//  RecipeService.swift
//  RecipeGenie
//
//  Created by Vineeth Kanaparthi on 11/20/23.
//

import Foundation
import Combine

/// `RecipeService` is a singleton class responsible for managing network requests related to recipes.
/// It encapsulates the functionality to fetch meal lists and meal details from "TheMealDB" API.
class RecipeService {
    
    // MARK: - Shared Instance
    /// The shared singleton instance for `RecipeService`.
    static let shared = RecipeService()
    
    /// Private initialization to ensure only one instance of the class is created.
    private init(){
        
    }
    
    // MARK: - Properties
    /// the number of retries to fetch meal details
    private var retryCount = 3
    
    /// A set to hold references to any cancellable operations (like network requests) so they are not deallocated prematurely.
    private var cancellables = Set<AnyCancellable>()
    
    /// base url for the meals db api
    private let baseUrl = "https://www.themealdb.com/api/json/v1/1"
    
    /// endpoint of the meals api to fetch dessert recipes
    private let mealsEndpoint = "/filter.php?c=Dessert"
    
    // MARK: - Network Request
    /// Performs a network request to the provided URL and completes with a list of meals or an error.
    ///
    /// - Parameters:
    ///   - url: The URL to perform the HTTP request.
    ///   - completion: A closure to be executed once the request is complete.
    private func performRequest(url: URL, completion: @escaping (Result<[Meal], Error>) -> Void) {
        URLSession.shared.dataTaskPublisher(for: url)
            .print("Network") // debug info
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .retry(retryCount)
            .decode(type: MealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completionResponse in
                switch completionResponse {
                case .finished:
                    break
                case .failure(let error):
                    completion(.failure(error))
                }
            }, receiveValue: { response in
                completion(.success(response.meals))
            })
            .store(in: &cancellables)
    }
    
    /// Fetches a list of meals from the API.
    ///
    /// - Parameter completion: A closure that receives a result containing either an array of `Meal` or an error.
    func fetchMeals(completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let url = URL(string: baseUrl + mealsEndpoint) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        performRequest(url: url, completion: completion)
    }
    
    /// Fetches detailed information for a specific meal by its ID.
    ///
    /// - Parameters:
    ///   - id: The unique identifier for the meal.
    ///   - completion: A closure that receives a result containing either an array of `Meal` or an error.
    func fetchMealDetail(for id: String, completion: @escaping (Result<[Meal], Error>) -> Void) {
        let mealDetailEndpoint = "/lookup.php?i=\(id)"
        guard let url = URL(string: baseUrl + mealDetailEndpoint) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        performRequest(url: url, completion: completion)
    }
    
}
