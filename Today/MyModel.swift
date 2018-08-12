//
//  MyModel.swift
//  Today
//
//  Created by 笠原未来 on 2018/07/17.
//  Copyright © 2018年 笠原未来. All rights reserved.
//

import RealmSwift

class realmDataSet: Object {
    @objc dynamic var date: Date? = nil
    @objc dynamic var title: Data? = nil
    @objc dynamic var memo: Data? = nil
}
