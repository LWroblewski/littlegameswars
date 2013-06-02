package com.gamewars.managers
{
  public class GameManager
  {
    /** Instance unique du GameManager */
    private static var sInstance:GameManager;
    /** Singleton */
    public static function getInstance() : GameManager
    {
      return sInstance;
    }
    
    /** Constructeur */
    public function GameManager()
    {
      if (sInstance) throw new Error('Singleton!');
      sInstance = this;
    }
  }
}