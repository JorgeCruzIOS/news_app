//
//  DatabaseCoordinator.swift
//  News
//
//  Created by Jorge Alfredo Cruz Acuña on 31/10/24.
//

import Foundation
import RealmSwift

typealias RealCodable = RealmSwift.Object & Codable

class DatabaseCoordinator{
    private let realm: Realm
    
    init() {
        do {
            self.realm = try Realm()
        } catch let error {
            fatalError("Error inicializando Realm: \(error)")
        }
    }
    
    func fetchOnDatabase<T:Object>(params search: [FilterModel], _ objectType: T.Type, completation:@escaping(_ response: T)->Void,
        failure:@escaping()->Void){
        let predicates = search.map { "\($0.key) = '\($0.value)'" }
        let predicateString = predicates.joined(separator: " AND ")
        let predicate = NSPredicate(format: predicateString)
        let item = realm.objects(T.self).filter(predicate).first
        if let itemNoNIL = item{
            completation(itemNoNIL)
        }else{
            failure()
        }
    }
    
    func updateOnDatabase<T: Object>(params search: [FilterModel], with newObject: T, completion: @escaping (_ response: Bool) -> Void) {
        
        let predicates = search.map { "\($0.key) = '\($0.value)'" }
        let predicateString = predicates.joined(separator: " AND ")
        let predicate = NSPredicate(format: predicateString)
        do {
            try realm.write {
                if let item = realm.objects(T.self).filter(predicate).first {
                    realm.delete(item)
                }
                realm.add(newObject)
                completion(true)
            }
        } catch {
            print("Error updating ArticleListCache: \(error)")
            completion(false)
        }
    }
}
