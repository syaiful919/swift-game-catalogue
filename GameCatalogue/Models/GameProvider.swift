//
//  GameProvider.swift
//  GameCatalogue
//
//  Created by Syaiful Salam on 15/08/21.
//

import Foundation
import CoreData

class GameProvider {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoriteGame")

        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil

        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil

        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }

    func getAllGame(completion: @escaping(_ games: [GameModel]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            do {
                let results = try taskContext.fetch(fetchRequest)
                var games: [GameModel] = []
                for result in results {
                    let game = GameModel(
                        id: result.value(forKeyPath: "game_id") as! Int32,
                        name: result.value(forKeyPath: "name") as! String,
                        description: result.value(forKeyPath: "game_description") as! String,
                        image: result.value(forKeyPath: "image") as! String,
                        released: result.value(forKeyPath: "released") as! String,
                        rating: result.value(forKeyPath: "rating") as! Int32,
                        metacritic: result.value(forKeyPath: "metacritic") as! Int32,
                        playtime: result.value(forKeyPath: "playtime") as! Int32,
                        platforms: result.value(forKeyPath: "platforms") as! String,
                        genres: result.value(forKeyPath: "genres") as! String,
                        ageRating: result.value(forKeyPath: "age_rating") as! String
                    )

                    games.append(game)
                }
                completion(games)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func getGame(_ id: Int, completion: @escaping(_ game: GameModel?) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "game_id == \(id)")

            do {
                if let result = try taskContext.fetch(fetchRequest).first {
                    let game = GameModel(
                        id: result.value(forKeyPath: "game_id") as! Int32,
                        name: result.value(forKeyPath: "name") as! String,
                        description: result.value(forKeyPath: "game_description") as! String,
                        image: result.value(forKeyPath: "image") as! String,
                        released: result.value(forKeyPath: "released") as! String,
                        rating: result.value(forKeyPath: "rating") as! Int32,
                        metacritic: result.value(forKeyPath: "metacritic") as! Int32,
                        playtime: result.value(forKeyPath: "playtime") as! Int32,
                        platforms: result.value(forKeyPath: "platforms") as! String,
                        genres: result.value(forKeyPath: "genres") as! String,
                        ageRating: result.value(forKeyPath: "age_rating") as! String
                    )

                    completion(game)
                } else {
                    completion(nil)
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    func createGame(_ input: GameModel, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: "Game", in: taskContext) {
                let game = NSManagedObject(entity: entity, insertInto: taskContext)
                self.getMaxId { id in
                    game.setValue(id+1, forKeyPath: "id")
                    game.setValue(input.id, forKeyPath: "game_id")
                    game.setValue(input.name, forKeyPath: "name")
                    game.setValue(input.description, forKeyPath: "game_description")
                    game.setValue(input.image, forKeyPath: "image")
                    game.setValue(input.released, forKeyPath: "released")
                    game.setValue(input.rating, forKeyPath: "rating")
                    game.setValue(input.metacritic, forKeyPath: "metacritic")
                    game.setValue(input.playtime, forKeyPath: "playtime")
                    game.setValue(input.platforms, forKeyPath: "platforms")
                    game.setValue(input.genres, forKeyPath: "genres")
                    game.setValue(input.ageRating, forKeyPath: "age_rating")

                    do {
                        try taskContext.save()
                        completion()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }

    func deleteGame(_ id: Int, completion: @escaping() -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "game_id == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion()
                }
            }
        }
    }

    func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
            let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastGame = try taskContext.fetch(fetchRequest)
                if let game = lastGame.first, let position = game.value(forKeyPath: "id") as? Int {
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
