//
//  Listing.swift
//  Markt
//
//  Created by Jordan Furr on 6/9/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import UIKit
import CodableFirebase
import Foundation

var departments: [String] = {
    ["AAPTIS", "AAS", "ACABS", "ACC", "ADABRD", "AERO", "AEROSP", "AMCULT", "ANATOMY", "ANTHRARC", "ANTHRBIO", "ANTHRCUL", "AOSS", "APPPHYS", "ARABAM", "ARABIC","ARCH", "ARMENIAN", "ARTDES", "ARTSADMN", "ASIAN", "ASIANLAN", "ASIANPAM", "ASTRO", "AT",
    "AUTO",
    "BA",
    "BCOM",
    "BCS",
    "BIOINF",
    "BIOLCHEM",
    "BIOLOGY",
    "BIOMED",
    "BIOPHYS",
    "BIOSTAT",
    "BIT",
    "BL",
    "BUDDHST",
    "BUSABRD",
    "CANCBIO",
    "CCS",
    "CDB",
    "CEE",
    "CHE",
    "CHEM",
    "CHEMBIO",
    "CIC",
    "CJS",
    "CLARCH",
    "CLCIV",
    "CLININST",
    "CLLING",
    "CMBIOL",
    "CMPLXSYS",
    "COGSCI",
    "COMM",
    "COMP",
    "COMPLIT",
    "CSP",
    "CZECH",
    "DANCE",
    "DENTHYG",
    "DESCI",
    "DOC",
    "DUTCH",
    "EARTH",
    "ECON",
    "EDCURINS",
    "EDUC",
    "EEB",
    "EECS",
    "EHS",
    "EIHLTH",
    "ELI",
    "EMBA",
    "ENGINSA",
    "ENGLISH",
    "ENGR",
    "ENS",
    "ENSCEN",
    "ENTR",
    "ENVIRON",
    "EPID",
    "ES",
    "ESENG",
    "EURO",
    "FAMMED",
    "FIN",
    "FINENG",
    "FRENCH",
    "GEOG",
    "GERMAN",
    "GREEK",
    "GREEKMOD",
    "GTBOOKS",
    "HBEHED",
    "HEBREW",
    "HF",
    "HHCR",
   "HISTART",
   "HISTORY",
   "HJCS",
   "HMP",
    "HONORS",
    "HUMGEN",
    "HYGDCE",
    "IMMUNO",
    "INSTHUM",
    "INTLSTD",
    "INTPERF",
    "IOE",
    "ISD",
    "ISLAM",
    "ITALIAN",
    "JAZZ",
    "JUDAIC",
    "KINESLGY",
    "KINSTUDY",
    "KRSTD",
    "LACS",
    "LATIN",
    "LATINOAM",
    "LAW",
    "LHC",
    "LHS",
    "LHSP",
    "LING",
    "MACROMOL",
    "MASSCOMM",
    "MATH",
    "MATSCIE",
    "MCDB",
    "MECHENG",
    "MEDCHEM",
    "MEDILLUS",
    "MEMS",
    "MENAS",
    "MFG",
    "MICRBIOL",
    "MILSCI",
    "MKT",
    "MO",
    "MOVESCI",
    "MSP",
    "MUSEUMS",
    "MUSICOL",
    "MUSMETH",
    "MUSPERF",
    "MUSPRACT",
    "NATIVEAM",
    "NAVARCH",
   "NAVSCI",
    "NEAREAST",
    "NERS",
    "NESLANG",
    "NEUROSCI",
    "NEURSURG",
    "NRE",
    "NSC",
    "NURS",
    "NUTR",
    "OMS",
    "ORGSTUDY",
    "ORTHSURG",
    "PAT",
    "PATH",
    "PERSIAN",
    "PHIL",
    "PHARMACY",
    "PHARMSCIL",
    "PHRMACOL",
    "PHYSED",
    "PHYSICS",
    "PHYSIOL",
    "PIANO",
    "PIBS",
    "PNE",
    "POLISH",
    "POLSCI",
    "PORTUG",
    "PPE",
   "PSYCH",
   " PUBHLTH",
    "PUBPOL",
    "RACKHAM",
    "RAV",
    "RCARTS",
    "RCCORE",
    "RCHUMS",
    "RCIDIV",
    "RCISCI",
    "RCLANG",
    "RCMATH",
    "RCNSCI",
    "RCSSCI",
    "REEES",
    "RELIGION",
    "ROB",
    "ROMLANG",
    "ROMLING",
    "RUSSIAN",
    "SAC",
    "SAS",
    "SCAND",
    "SEAS",
    "SEND",
    "SI",
    "SLAVIC",
    "SM",
    "SOC",
    "SOCAMIN",
    "SPANISH",
    "STATS",
    "STDABRD",
    "STDEXCH",
    "STRATEGY",
    "SURVMETH",
    "SW",
    "TCHNCLCM",
    "THEORY",
    "THTREMUS",
    "TO",
    "TURKISH",
    "UARTS",
    "UC",
    "UD",
    "UKR",
    "UMOVE",
    "UP",
    "UROLOGY",
    "WOMENSTD",
    "WRITING",
    "YIDDISH"]
}()

var furnitureTypes: [String] = {
    ["Couch", "Bed", "Chair", "Desk", "Table", "Light", "Beanbag"]
}()

var sizes: [String] = {
    ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL"]
}()

var subletTypes: [String] = {
    ["Private Room", "Entire Aparmtent", "Entire House", "Shared Room", "Other"]
}()

var sports: [String] = {
    ["Football", "Basketball", "Hockey", "Soccer", "Tennis"]
}()

var popularClasses: [String] = {
    ["Econ 101", "Econ 102", "Math 115", "Psych 211", "COMM 102"]
}()

var freeCategories: [String] = {
    ["Books", "Furniture", "Electronics", "Tickets", "Clothing", "Transportation"]
}()


class Listing: Codable {
    
    enum CodingKeys: String, CodingKey {
        case uid, title, price, description, ownerUID, iconPhotoID, category, subcategory, subsubCategory, imageURLS
    }
    var uid: String
    var title: String
    var category: String
    var subcategory: String = ""
    var subsubCategory: String = "" //class Number for books, size for clothes, opponent for ticket
    var price: Double
    var description: String
    var ownerUID: String
    var date: Date = Date()
    var imageURLS: [String] = []
    var images: [UIImage] = []
    
    var iconPhotoID: String
    var iconImage: UIImage? = nil
    var iconImageData: Data? {
        guard let iconImage = iconImage else { return nil }
        return iconImage.jpegData(compressionQuality: 0.5)
    }
    
    init(title: String, subcategory: String, subsubCategory: String, price: Double, description: String, ownerUID: String, iconPhotoID: String, category: String) {
        self.uid = UUID().uuidString
        self.title = title
        self.subsubCategory = subsubCategory
        self.subcategory = subcategory
        self.price = price
        self.description = description
        self.ownerUID = ownerUID
        self.iconPhotoID = iconPhotoID
        self.category = category
        self.date = Date()
    }
}
