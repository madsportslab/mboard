//
//  mboard.swift
//  mBoard
//
//  Created by hu on 4/2/17.
//  Copyright © 2017 madsportslab. All rights reserved.
//

import UIKit

class Mboard {
    
    static let HTTP             = "http://"
    static let HTTPS            = "https://"
    static let WS               = "ws://"
    static let WSS              = "wss://"
    
    static let SOCKET           = "ws://127.0.0.1:8000/ws"
    static let GAMESOCKET       = SOCKET + "/game"
    
    static let WWW              = "http://127.0.0.1:8000"
    static let GAMES            = WWW + "/api/games"
    static let SCORES           = WWW + "/api/scores"
    
    static let MADSPORTSLAB     = "http://127.0.0.1:8110"
    static let UPDATESERVICE    = "http://172.16.130.215:8900"
    
    static let MBOARD           = "mboard."
    static let PERIODS          = MBOARD + "periods"
    static let MINUTES          = MBOARD + "minutes"
    static let SHOTCLOCK        = MBOARD + "shotclock"
    static let FOULS            = MBOARD + "fouls"
    static let TIMEOUTS         = MBOARD + "timeouts"
    static let HOMENAME         = MBOARD + "home"
    static let AWAYNAME         = MBOARD + "away"
    static let SERVER           = MBOARD + "server"
    static let SAVED_SERVERS    = MBOARD + "savedservers"
    static let GAME             = MBOARD + "game"
    
    // /ws/game commands
    
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
    static let WS_PERIOD            = "PERIOD"
    static let WS_SCORE_HOME        = "SCORE_HOME"
    static let WS_SCORE_AWAY        = "SCORE_AWAY"
    static let WS_FOUL_HOME_UP      = "FOUL_HOME_UP"
    static let WS_FOUL_HOME_DOWN    = "FOUL_HOME_DOWN"
    static let WS_FOUL_AWAY_UP      = "FOUL_AWAY_UP"
    static let WS_FOUL_AWAY_DOWN    = "FOUL_AWAY_DOWN"
    static let WS_TIMEOUT_HOME      = "TIMEOUT_HOME"
    static let WS_TIMEOUT_HOME_CANCEL = "TIMEOUT_HOME_CANCEL"
    static let WS_TIMEOUT_AWAY      = "TIMEOUT_AWAY"
    static let WS_TIMEOUT_AWAY_CANCEL = "TIMEOUT_AWAY_CANCEL"
    
    // /ws/manager commands
    
    static let WS_LOGO              = "LOGO"
    static let WS_SETUP             = "SETUP"
    static let WS_SCOREBOARD        = "SCOREBOARD"
    static let WS_ADVERTISEMENT     = "ADVERTISEMENT"
    static let WS_SCREENSAVER       = "SCREENSAVER"
    static let WS_VIDEO_PLAY        = "VIDEO_PLAY"
    static let WS_VIDEO_STOP        = "VIDEO_STOP"
    static let WS_PHOTO_PLAY        = "PHOTO_PLAY"
    static let WS_PHOTO_STOP        = "PHOTO_STOP"
    static let WS_AUDIO_PLAY        = "AUDIO_PLAY"
    static let WS_AUDIO_STOP        = "AUDIO_STOP"

    static let PLAYING              = "Playing"
    static let BLANK                = ""
    
    static let TAG_HOME             = "HOME"
    static let TAG_AWAY             = "AWAY"
    
    static let MAX_WS_ERRORS        = 20
    
    
    static let TealColor     = UIColor(
        red: 1/255, green: 129/255, blue: 186/255, alpha: 1)
    
    static let NeonGreenColor = UIColor(
        red: 53/255, green: 255/255, blue: 48/255, alpha: 1)
    
    static let YellowColor = UIColor(
        red: 255/255, green: 255/255, blue: 51/255, alpha: 1)
    
    static let Periods = ["1st", "2nd", "3rd", "4th"]
    
} // Mboard
