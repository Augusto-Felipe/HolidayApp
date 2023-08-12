//
//  Strings.swift
//  HolidayApp
//
//  Created by Felipe Augusto Correia on 12/08/23.
//

import Foundation

enum AlertTitle: String {
    case alertButtonTitle = "OK"
    case alertErrorTitle = "Erro"
    case alertErrorMessage = "Ano não suportado."
}

enum Onboarding: String {
    case onboardingImageName = "onboard"
    case onboardingAppDescription = "Descubra os principais feriados de cada país"
    case onboardingDescription = """
    Com o Holiday App você fica por dentro dos
    principais feriados de mais de 100 países
    diferentes
    """
    case onboardingButtonTitle = "Vamos"
}

enum HomeScreenEnum: String {
    case backgroundImageName = "background"
    case appLogoImageName = "logo2"
    case searchButtonTitle = "Pesquisar"
}

enum HolidayScreenEnum: String {
    case backButonImageName = "back"
    case navigationTitle = "Feriados"
}

enum DetailScreenEnum: String {
    case backButtonImageName = "back"
    case navigationTitle = "Detalhes"
    case nameLabelText = "Nome"
    case localNameLabelText = "Nome Local"
    case dateLabelText = "Data"
    
}

enum Key: String {
    case textColorKey = "textColor"
}

enum DictionaryKeys: String {
    case code = "code"
    case name = "name"
}


