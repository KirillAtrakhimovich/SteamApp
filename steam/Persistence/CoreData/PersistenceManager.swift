//
//  PersistenceManager.swift
//  steam
//
//  Created by Kirill Atrakhimovich on 18.08.22.
//

import Foundation
import UIKit

final class PersistenceManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func getFavoriteGames() -> [Favorite] {
        let fetchRequest = Favorite.fetchRequest()
        do {
            let objects = try context.fetch(fetchRequest)
            return objects
        } catch {
            return [Favorite]()
        }
    }
    
    func getFavoriteGame(by id: Int) -> Favorite? {
        let fetchRequest = Favorite.fetchRequest()

        fetchRequest.predicate = NSPredicate(
            format: "id = %@", "\(id)"
        )

        if let object = try? context.fetch(fetchRequest).first {
            return object
        } else {
            return nil
        }
    }
    
    func saveFavorite(model: LocalFavoriteGame) {
        switch model.isFavorite {
        case true:
            save(model: model)
        case false:
            delete(id: model.id)
        }
    }
    
    private func save(model: LocalFavoriteGame) {
        let favGame = Favorite(context: context)
        favGame.id = model.id
        favGame.price = model.price
        favGame.isDiscount = model.isDiscount
        favGame.name = model.name
        favGame.discount = model.discount
        favGame.isFree = model.isFree
        favGame.finalPrice = model.finalPrice
        try? context.save()
    }
    
        func delete(id: Int) {
        guard let favorite = getFavoriteGame(by: id) else { return }
        context.delete(favorite)
        try? context.save()
    }
}
