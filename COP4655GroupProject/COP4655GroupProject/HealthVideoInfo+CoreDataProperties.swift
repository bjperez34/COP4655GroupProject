//
//  HealthVideoInfo+CoreDataProperties.swift
//  COP4655GroupProject
//
//  Created by Bert Perez on 4/26/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import Foundation
import CoreData


extension HealthVideoInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HealthVideoInfo> {
        return NSFetchRequest<HealthVideoInfo>(entityName: "HealthVideoInfo")
    }

    @NSManaged public var healthVideoDescription: String?
    @NSManaged public var healthVideoUrlCode: String?

}
