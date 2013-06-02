package com.gamewars.screens
{
  import com.gamewars.enums.UnitType;
  import com.gamewars.misc.CellInfoView;
  import com.gamewars.states.AbstractGameState;
  import com.gamewars.states.FreeState;
  import com.gamewars.states.transitional.DayCycleState;
  import com.gamewars.structures.TileMap;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.mapgen.MapGenerator;
  import com.gamewars.world.World;
  
  import flash.display.Sprite;
  
  import starling.core.Starling;
  import starling.events.EnterFrameEvent;
  import starling.events.Touch;
  import starling.events.TouchEvent;

  /**
  * Ecran principal de jeu
  */
  public class GameScreen extends BaseScreen
  {
    /** Vue du jeu */
    public var mWorldView:World;
    /** Layers */
    public var mFightScreen:FightScreen;
    
    /** Etat du jeu */
    private var mCurrentState:AbstractGameState;
    private var mNextState:AbstractGameState;
    public function setState(pState:AbstractGameState) : void
    {
      mNextState = pState;
    }
    
    /** Informations sur la tile en cours */
    public var mCellInfoView:CellInfoView;
    /** Dernier touch mémorisé */
    private var mLastTouch:Touch;
    
    /** Constructeur */
    public function GameScreen()
    {
      super();
      
      initialize();
      addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
      addEventListener(TouchEvent.TOUCH, onTouch);
      setState(new DayCycleState(this));
    }
    
    /** Gestion du touch */
    private function onTouch(pEvent:TouchEvent) : void
    {
      mLastTouch = pEvent.touches[0];
    }
    
    /** EnterFrame */
    private function onEnterFrame(pEvent:EnterFrameEvent) : void
    {
      // Gestion du changement d'état
      if (mNextState != null)
      {
        if (mCurrentState != null)
        {
          mCurrentState.exitState();
        }
        mCurrentState = mNextState;
        mNextState = null;
        if (mCurrentState != null)
        {
          mCurrentState.enterState();
        }
        // Annule le dernier evenement
        mLastTouch = null;
      }
      // Gestion du touch
      if (mLastTouch != null)
      {
        if (mCurrentState != null)
          mCurrentState.manageTouch(mLastTouch);
        mLastTouch = null;
      }
      // Update
      if (mCurrentState != null)
      {
        mCurrentState.update(pEvent.passedTime);
      }
      
      // Maj du monde
      mWorldView.update(pEvent.passedTime);
    }
    
    /** Initialisation du jeu */
    private function initialize() : void
    {
      mWorldView = new World();
      addChild(mWorldView);
      
      mCellInfoView = new CellInfoView();
      mCellInfoView.x = 0;
      mCellInfoView.y = 500;
      addChild(mCellInfoView);
      
      mFightScreen = new FightScreen();
      mFightScreen.visible = false;
      addChild(mFightScreen);
      
      // DBG
      // ------------------------------------------------------------------------
      var gen:MapGenerator = new MapGenerator(20,20);
      mWorldView.setMap(gen.newMap());
      
      mWorldView.addEntity(new Unit(10, 10, UnitType.INFANTRY));
      mWorldView.addEntity(new Unit(10, 11, UnitType.INFANTRY));
      // ------------------------------------------------------------------------
    }
  }
}