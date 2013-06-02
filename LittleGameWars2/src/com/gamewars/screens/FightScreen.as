package com.gamewars.screens
{
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.world.World;
  
  import starling.core.Starling;
  import starling.display.Image;
  import starling.display.MovieClip;

  /**
  * Ecran de combat entre deux unitées
  **/
  public class FightScreen extends BaseScreen
  {
    /** Images d'arrière plans */
    private var mLeftPart:SplitPart;
    private var mRightPart:SplitPart;
    
    /** Renderers d'unitées */
    private var mRenderers:Vector.<MovieClip> = new <MovieClip>[];
    
    /** Constructeur */
    public function FightScreen()
    {
      super();
      mLeftPart = new SplitPart(SplitPart.FACING_RIGHT);
      addChild(mLeftPart);
      mRightPart = new SplitPart(SplitPart.FACING_LEFT);
      addChild(mRightPart);
    }
    
    /** Indique si l'animation est terminée */
    public function isAnimationFinished() : Boolean
    {
      return mLeftPart.isAnimationFinished();
    }
    
    /** Affiche le combat entre deux unitées */
    public function renderFight(pUnit:Unit, pTarget:Unit, pWorld:World) : void
    {
      var ww:Number = Starling.current.stage.width / 2;
      var hh:Number = Starling.current.stage.height;
      mLeftPart.renderFight(pUnit, pWorld);
      mLeftPart.width = ww;
      mLeftPart.height = hh;
      mRightPart.renderFight(pTarget, pWorld);
      mRightPart.x = ww;
      mRightPart.width = ww;
      mRightPart.height = hh;
    }
    
    /** Maj */
    public function update(pTimeDelta:Number) : void
    {
      mLeftPart.update(pTimeDelta);
      mRightPart.update(pTimeDelta);
    }
  }
}

// ------------------------------------------------------------------------
// SplitPart
// ------------------------------------------------------------------------
import com.gamewars.structures.Unit;
import com.gamewars.utils.Resources;
import com.gamewars.world.World;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;

class SplitPart extends Sprite
{
  public static const FACING_LEFT:String = 'FACING_LEFT';
  public static const FACING_RIGHT:String = 'FACING_RIGHT';
  
  private const ANIMATION_DURATION:int = 5; // Secondes d'animation
  
  /** Réference vers la case affichée */
  private var mUnit:Unit;
  /** Direction */
  private var mFacing:String;
  /** Texture d'arrière plan */
  private var mBg:Image;
  /** Liste des renderers */
  private var mRenderers:Vector.<MovieClip> = new <MovieClip>[];
  
  /** Compteur de temps écoulé */
  private var mTimeEllapsed:Number;
  
  /** Constructeur */
  public function SplitPart(pFacing:String)
  {
    mFacing = pFacing;
    mBg = new Image(Resources.emptyTex(1,1));
    addChild(mBg);
  }
  
  /** Effectue le rendu */
  public function renderFight(pUnit:Unit, pWorld:World) : void
  {
    mTimeEllapsed = 0;
    mBg.texture = Resources.getBackgroundTex('plain');
    mBg.readjustSize();
    
    // Crée les renderers pour les units
    var rd:MovieClip = new MovieClip(Resources.getUnitTextures(pUnit.mUnitType), 8);
    rd.y = mBg.height - rd.height - 10;
    rd.x = mBg.width/2 - rd.width;
    mRenderers.push(rd);
    addChild(rd);
  }
  
  /** Indique si l'animation est terminée */
  public function isAnimationFinished() : Boolean
  {
    return mTimeEllapsed >= ANIMATION_DURATION;
  }
  
  /** Nettoyage */
  private function clear() : void
  {
    for each (var rd:MovieClip in mRenderers)
    {
      removeChild(rd);
    }
  }
  
  /** Maj */
  public function update(pTimeDelta:Number) : void
  {
    // Fin de l'animation
    if (isAnimationFinished())
    {
      return;
    }
    
    mTimeEllapsed += pTimeDelta;
    
    // Maj des sprites
    for each (var rd:MovieClip in mRenderers)
    {
      rd.advanceTime(pTimeDelta);
    }
  }
}