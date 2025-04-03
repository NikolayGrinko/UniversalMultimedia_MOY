//
//  ToDoEntity.swift
//  UniversalMultimedia_MOY
//
//  Created by Николай Гринько on 31.01.2025.

import UIKit
import CoreData

@objc(ToDoEntity)
public class ToDoEntity: NSManagedObject {}

extension ToDoEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoEntity> {
        return NSFetchRequest<ToDoEntity>(entityName: "ToDoEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var todo: String
    @NSManaged public var completed: Bool
    @NSManaged public var createdAt: Date
    @NSManaged public var userId: Int
}

