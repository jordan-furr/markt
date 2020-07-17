//
//  InfoStringArrays.swift
//  Markt
//
//  Created by Jordan Furr on 7/17/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

var categories: [String] = {
    ["books", "furniture", "electronics", "tickets", "clothing", "transportation", "free", "housing"]
}()

var topDepartments: [String] = {
    ["ARTDES", "CHEM", "COMM", "EDUC", "EECS", "ENGLISH", "MATH", "PHYSICS", "POLSCI", "PSYCH", "SOC", "SPANISH", "STATS", "WOMENSTD"]
}()

var transportTypes: [String] = {
    ["Scooter", "Car", "Boards", "Under $50", "Rentals", "Other"]
}()

var electronicTypes: [String] = {
    ["Gaming", "For class", "Calculators", "Under 15$", "Under 50$", "Cords/etc"]
}()

var furnitureTypes: [String] = {
    ["Couch", "Bed", "Chair", "Desk", "Table", "Lights/Lamps"]
}()

var sizes: [String] = {
    ["XXS", "XS", "S", "M", "L", "XL", "XXL", "XXXL"]
}()

var clothingTypes: [String] = {
   ["Shirts", "Pants", "Jackets", "Shoes", "Accesories", "Gameday"]
}()

var subletTypes: [String] = {
    ["Room in Apt", "Room in House", "Entire Apartment", "Entire House", "Shared Room", "Other"]
}()

var sports: [String] = {
    ["Football", "Basketball", "Hockey"]
}()

var popularClasses: [String] = {
    ["Econ 101", "Econ 102", "Math 115", "Math 116", "Psych 211", "COMM 102"]
}()

var freeCategories: [String] = {
    ["Books", "Furniture", "Electronics", "Tickets", "Clothing", "Transportation"]
}()

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
   "PUBHLTH",
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

class InfoStringArrays {
    
}
