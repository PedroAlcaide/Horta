//
//  DaoFactory.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//

import Foundation
class DaoFactory {
    func getUserDAOCloudKit()->UserDAOCloudKit{
        return UserDAOCloudKit()
    }
    func getUserDAODefaults()->UserDAODefaults{
        return UserDAODefaults()
    }
    
    func getProductCloudKit()->ProductDAOCloudKit{
        return ProductDAOCloudKit()
    }
    
    func getGardenDAOCloudKit()->GardenDAOCLoudKit{
        return GardenDAOCLoudKit()
    }
    
    func getAddressDAOCloudKit()->AddressDAOCLoudKit{
        return AddressDAOCLoudKit()
    }
    
}

//+(UserDAOCloudKit*)getUserDAOCloudKit;
//+(UserDAONSDefaults*)getUserDAONSDefaults;