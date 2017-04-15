//
//  mboard.swift
//  mBoard
//
//  Created by hu on 4/2/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

class Mboard {
    
    static let SOCKET           = "ws://127.0.0.1:8000/ws"
    static let GAMESOCKET       = SOCKET + "/game"
    
    static let WWW              = "http://127.0.0.1:8000"
    static let GAMES            = WWW + "/api/games"
    
    
    static let MBOARD           = "mboard."
    static let PERIODS          = MBOARD + "periods"
    static let MINUTES          = MBOARD + "minutes"
    static let SHOTCLOCK        = MBOARD + "shotclock"
    static let FOULS            = MBOARD + "fouls"
    static let TIMEOUTS         = MBOARD + "timeouts"
    
    // ws commands
    
    static let WS_CLOCK_START       = "CLOCK_START"
    static let WS_CLOCK_STOP        = "CLOCK_STOP"
    static let WS_CLOCK_RESET       = "CLOCK_RESET"
    static let WS_CLOCK_STEP        = "CLOCK_STEP"
    static let WS_SHOT_RESET        = "SHOT_RESET"
    static let WS_SHOT_STEP         = "SHOT_STEP"
    static let WS_PERIOD_UP         = "PERIOD_UP"
    static let WS_PERIOD_DOWN       = "PERIOD_DOWN"
    static let WS_POSSESSION_HOME   = "POSSESSION_HOME"
    static let WS_POSSESSION_AWAY   = "POSSESSION_AWAY"
    static let WS_FINAL             = "FINAL"
    static let WS_ABORT             = "ABORT"
    static let WS_SCORE_HOME        = "SCORE_HOME"
    static let WS_SCORE_AWAY        = "SCORE_AWAY"
    static let WS_FOUL_HOME_UP      = "FOUL_HOME_UP"
    static let WS_FOUL_HOME_DOWN    = "FOUL_HOME_DOWN"
    static let WS_FOUL_AWAY_UP      = "FOUL_AWAY_UP"
    static let WS_FOUL_AWAY_DOWN    = "FOUL_AWAY_DOWN"
    static let WS_TIMEOUT_HOME_UP   = "TIMEOUT_HOME_UP"
    static let WS_TIMEOUT_HOME_DOWN = "TIMEOUT_HOME_DOWN"
    static let WS_TIMEOUT_AWAY_UP   = "TIMEOUT_AWAY_UP"
    static let WS_TIMEOUT_AWAY_DOWN = "TIMEOUT_AWAY_DOWN"
    
    
    static let TealColor     = UIColor(
        red: 1/255, green: 129/255, blue: 186/255, alpha: 1)
    
    static let NeonGreenColor = UIColor(
        red: 53/255, green: 255/255, blue: 48/255, alpha: 1)
    
    static let YellowColor = UIColor(
        red: 255/255, green: 255/255, blue: 51/255, alpha: 1)
    
    
} // Mboard