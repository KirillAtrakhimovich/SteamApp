import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case emptyData
    case parsingError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Was sending invalid URL."
        case .emptyData:
            return "No data here."
        case .parsingError:
            return "Met parsing error."
        }
    }
}

final class NetworkManager {

    let stringURL = Constants.getApiList
    let stringURL2 = Constants.getAppDetails
    func downloadImage(imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let downoladImageURL = URL(string: imageURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: downoladImageURL)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
           
            if let image =  UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
    
    func getGameDetails(gameid: Int, completion: @escaping (Result<GameModel, Error>) -> Void) {
        let gameURL = "\(stringURL2)\(gameid)"
        guard let url = URL(string: gameURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }

            if let mainObject = try? JSONDecoder().decode(GameModel.self, from: data) {
                completion(.success(mainObject))
            } else {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }

    func getGamesList(completion: @escaping (Result<[Game], Error>) -> Void) {
        
        guard let url = URL(string: stringURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }

            if let mainObject = try? JSONDecoder().decode(AppList.self, from: data) {
                completion(.success(mainObject.applist.apps))
            } else {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
    
    func getNewsInfo(gameId: Int, completion: @escaping (Result<Items, Error>) -> Void) {
        let gameNewsURL = "https://api.steampowered.com/ISteamNews/GetNewsForApp/v2/?appid=\(gameId)&count=10"
        guard let url = URL(string: gameNewsURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            if let mainObject = try? JSONDecoder().decode(News.self, from: data) {
                completion(.success(mainObject.appnews))
            } else {
                completion(.failure(NetworkError.parsingError))
            }
        }.resume()
    }
}

extension NetworkManager {
    struct Constants {
        static let getApiList = "https://api.steampowered.com/ISteamApps/GetAppList/v2/?"
        static let getAppDetails = "https://store.steampowered.com/api/appdetails?appids="
    }
}
