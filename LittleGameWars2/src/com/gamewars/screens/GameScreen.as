package com.gamewars.screens
{
  import com.gamewars.core.GameEngine;
  import com.gamewars.enums.CommanderType;
  import com.gamewars.enums.Commanders;
  import com.gamewars.enums.UnitType;
  import com.gamewars.gfx.CellInfoView;
  import com.gamewars.gfx.Hud;
  import com.gamewars.states.AbstractGameState;
  import com.gamewars.states.FreeState;
  import com.gamewars.states.transition.DayCycleState;
  import com.gamewars.structures.Player;
  import com.gamewars.structures.TileMap;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.mapgen.MapGenerator;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.display.Sprite;
  import flash.geom.Point;
  
  import starling.core.Starling;
  import starling.events.EnterFrameEvent;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;

  /**
  * Ecran principal de jeu
  */
  public class GameScreen extends BaseScreen
  {
    /** Vue du jeu */
    public var mWorld:World;
    /** Informations sur la tile sélectionnée */
    private var mCellInfoView:CellInfoView;
    /** Informations de joueur */
    private var mHud:Hud;
    // ------------------------------------------------------------------------
    /** Etat du jeu */
    private var mCurrentState:AbstractGameState;
    private var mNextState:AbstractGameState;
    public function setState(pState:AbstractGameState) : void
    {
      mNextState = pState;
    }
    // ------------------------------------------------------------------------
    /** Dernier touch mémorisé */
    private var mLastTouch:Touch;
    /** Liste des joueurs */
    public var mPlayers:Vector.<Player> = new <Player>[];
    /** Joueur en cours */
    public var mCurrentPlayer:Player;
    /** Moteur de jeu */
    public var mGameEngine:GameEngine;
    
    /** Constructeur */
    public function GameScreen()
    {
      super();
      
      initialize();
      addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrame);
      addEventListener(TouchEvent.TOUCH, onTouch);
      setState(new DayCycleState(this));
      
      dbgNewGame();
    }
    
    /** Positionne les éléments */
    private function updateLayout() : void
    {
      var gap:Number = 5;
      mHud.x = gap;
      mHud.y = gap;
      mCellInfoView.x = gap;
      mCellInfoView.y = Starling.current.stage.stageHeight - mCellInfoView.height - gap;
    }
    
    /** Active le joueur suivant */
    public function nextPlayer() : Player
    {
      // Sélectionne le joueur suivant
      if (mCurrentPlayer == null || mPlayers.indexOf(mCurrentPlayer) == mPlayers.length-1)
        mCurrentPlayer = mPlayers[0];
      else
        mCurrentPlayer = mPlayers[mPlayers.indexOf(mCurrentPlayer)+1];
      
      // Maj HUD
      mHud.setInfo(mCurrentPlayer);
      mHud.visible = true;
      return mCurrentPlayer;
    }
    
    /** Gestion du touch */
    private function onTouch(pEvent:TouchEvent) : void
    {
      
      // Scrolling
      if (pEvent.touches[0].phase == TouchPhase.MOVED)
      {
        var movement:Point = pEvent.touches[0].getMovement(mWorld);
        mWorld.mScrollPosition.offset(-movement.x, -movement.y);
      }
      else
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
      mWorld.update(pEvent.passedTime);
    }
    
    private function dbgNewGame() : void
    {
      var p:Player = new Player();
      p.mCommander = Commanders.getByName(Commanders.ANDY);
      p.addUnit(new Unit(10, 10, UnitType.INFANTRY));
      p.addUnit(new Unit(10, 11, UnitType.INFANTRY));
      addPlayer(p);
      
      //p = new Player();
      //p.mCommander = CommanderType.CO_ANDY;
      //p.addUnit(new Unit(12, 12, UnitType.INFANTRY));
      //p.addUnit(new Unit(12, 13, UnitType.INFANTRY));
      //addPlayer(p);
    }
    
    /** Ajoute un joueur au jeu */
    private function addPlayer(pPlayer:Player) : void
    {
      mPlayers.push(pPlayer);
      mWorld.addPlayer(pPlayer);
    }
    
    /** Définit les informations de tile à afficher */
    public function displayCellInfo(pCell:WorldCell) : void
    {
      mCellInfoView.setCellInfo(pCell);
      mCellInfoView.visible = true;
      updateLayout();
    }
    
    /** Initialisation du jeu */
    private function initialize() : void
    {
      var gen:MapGenerator = new MapGenerator(64,64);
      mWorld = new World(gen.newMap());
      addChild(mWorld);
      
      mGameEngine = new GameEngine(mWorld);
      
      mCellInfoView = new CellInfoView();
      mCellInfoView.visible = false;
      addChild(mCellInfoView);
      
      mHud = new Hud();
      mHud.visible = false;
      addChild(mHud);
      
      updateLayout();
    }
  }
}