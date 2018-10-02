//
//  realmDataSet.swift
//  note
//
//  Created by 笠原未来 on 2018/05/22.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import UIKit
import RealmSwift

class realmDataSet: Object {
    @objc dynamic var date: Date? = nil
    @objc dynamic var recordDate: Date? = nil
    @objc dynamic var title: Data? = nil
    @objc dynamic var memo: Data? = nil
}
