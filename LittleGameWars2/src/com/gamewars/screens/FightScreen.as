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
      return mLeftPart.isAnimationFinished() && mRightPart.isAnimationFinished();
    }
    
    /** Affiche le combat entre deux unitées */
    public function renderFight(pUnit:Unit, pTarget:Unit, pWorld:World) : void
    {
      var ww:Number = Starling.current.stage.stageWidth / 2;
      var hh:Number = Starling.current.stage.stageHeight;
      mLeftPart.renderFight(pUnit);
      mLeftPart.width = ww;
      mLeftPart.height = hh;
      mRightPart.renderFight(pTarget);
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
import com.gamewars.components.GwImage;
import com.gamewars.components.GwMovieClip;
import com.gamewars.structures.Unit;
import com.gamewars.utils.Resources;
import com.gamewars.world.World;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

class SplitPart extends Sprite
{
  public static const FACING_LEFT:String = 'FACING_LEFT';
  public static const FACING_RIGHT:String = 'FACING_RIGHT';
  
  // Animations dans le désordre car chaque ligne réference la précedante
  private const IDLE:Object   = {animation:'IDLE',    endTime:6};
  private const FIRING:Object = {animation:'FIRING',  endTime:3.5, next:IDLE};
  private const WAIT:Object   = {animation:'IDLE',    endTime:1.5, next:FIRING};
  private const MOVING:Object = {animation:'MOVING',  endTime:1, next:WAIT};
  
  private var mCurrentStep:Object;
  
  /** Réference vers l'unitée affichée */
  private var mUnit:Unit;
  /** Direction */
  private var mFacing:String;
  /** Texture d'arrière plan */
  private var mBg:Image;
  /** Liste des renderers */
  private var mRenderers:Vector.<InfantryAnimation> = new <InfantryAnimation>[];
  
  /** Compteur de temps écoulé */
  private var mTimeEllapsed:Number;
  
  /** Constructeur */
  public function SplitPart(pFacing:String)
  {
    mFacing = pFacing;
    mBg = new GwImage(Resources.emptyTex(1,1));
    addChild(mBg);
  }
  
  /** Effectue le rendu */
  public function renderFight(pUnit:Unit) : void
  {
    // Nettoyage
    clear();
    // Rend le terrain
    mBg.texture = Resources.getBackgroundTex('plain');
    // Rend les unitées
    var rd:InfantryAnimation = new InfantryAnimation();
    rd.x = 0;
    rd.y = mBg.height - rd.height - 25;
    mRenderers.push(rd);
    addChild(rd);
  }
  
  /** Indique si l'animation est terminée */
  public function isAnimationFinished() : Boolean
  {
    return mTimeEllapsed >= IDLE.endTime;
  }
  
  /** Nettoyage */
  private function clear() : void
  {
    mTimeEllapsed = 0;
    mCurrentStep = MOVING;
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
    if (mTimeEllapsed >= mCurrentStep.endTime && 
      mCurrentStep.next != null)
    {
      setStep(mCurrentStep.next);
    }
    
    // Maj des sprites
    for each (var rd:MovieClip in mRenderers)
    {
      rd.advanceTime(pTimeDelta);
    }
  }
  
  /** Active l'animation de tir */
  private function setStep(pStep:Object) : void
  {
    for each (var rd:InfantryAnimation in mRenderers)
    {
      rd.setAnimation(pStep.animation);
    }
    mCurrentStep = pStep;
  }
}

// ------------------------------------------------------------------------
// Définition d'animation d'unité
// ------------------------------------------------------------------------
class InfantryAnimation extends GwMovieClip
{
  /** Animation en cours */
  private var mCurrentAnimation:String;
  
  /** Constructeur */
  public function InfantryAnimation()
  {
    mCurrentAnimation = 'MOVING';
    super(getAnimationTexs(mCurrentAnimation), 8);
  }
  
  /** @inheritDoc */
  override public function advanceTime(passedTime:Number):void
  {
    super.advanceTime(passedTime);
    
    if (mCurrentAnimation == 'MOVING')
      x += passedTime * 50;
  }
  
  /** Retourne les textures pour l'animation */
  private function getAnimationTexs(pName:String) : Vector.<Texture>
  {
    switch(pName)
    {
      // TODO Ref avec SplitPart
      case 'MOVING':
        return Resources.getBigUnitTexs('InfantryRun');
        break;
      case 'FIRING':
        return Resources.getBigUnitTexs('InfantryFire');
        break;
      case 'IDLE':
        return Resources.getBigUnitTexs('InfantryIdle');
        break;
      default:
        return null;
        break;
    }
  }
  
  /** Modifie le clip pour jouer l'animation passée en paramètres */
  public function setAnimation(pName:String) : void
  {
    fps = pName == 'FIRING'?18:8;
    if (mCurrentAnimation != pName)
    {
      mCurrentAnimation = pName;
      // Enlève toutes les frames sauf la dernière (IllegalOperationError)
      while (numFrames > 1)
      {
        removeFrameAt(1);
      }
      // Selectionne les frames de l'animation
      var texs:Vector.<Texture> = getAnimationTexs(pName);
      setFrameTexture(0, texs[0]);
      // FIXME : Quand y'a que 1 textures, l'animation n'est pas maj...
      if (texs.length == 1)
        addFrame(texs[0]);
      while (numFrames < texs.length)
      {
        addFrame(texs[numFrames]);
      }
    }
  }
}