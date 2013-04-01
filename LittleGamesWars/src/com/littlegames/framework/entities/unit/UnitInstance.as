package com.littlegames.framework.entities.unit
{
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.Utils;
  
  import starling.core.Starling;
  import starling.display.MovieClip;
	
	/** Occurence d'une unité. */
	public class UnitInstance
	{
    /** Max HPs d'une unité */
		public static const MAX_HP:uint = 10;
    // ------------------------------------------------------------------------
		/** Type de l'unité. */
		public var unit:UnitType;
    
    /** Identifiant du type d'unité. */
    public function get unitId():String
    {
      return unit.id;
    }
    
		/** Points de vie courants (10 au maximum). */
		public var hp:uint;
		/** Position x sur la map. */
		public var x:uint;
		/** Position y sur la map. */
		public var y:uint;
    /** Indique si l'unité peut agir ou non */
    public var enabled:Boolean;
    // ------------------------------------------------------------------------
    /** MovieClip associé à l'unité. */
    public var unitMovieClip:MovieClip;
    
    /** Constructeur */
		public function UnitInstance(pUnit:UnitType, pHp:uint = MAX_HP, pX:uint = 0, pY:uint = 0, pEnabled:Boolean = false)
		{
      unit = pUnit;
			hp = pHp;
      x = pX;
      y = pY;
      enabled = pEnabled;
		}
    
    /** @inheritDoc */
    public function update(pTimeDelta:Number) : void
    {
      
    }
    
    /** Suppression du movieClip. */
    public function remove():void
    {
      /*if (_unitMovieClip)
      {
        Resources.remove(_unitMovieClip);
      }*/
    }
    
    /** Déplacement de l'unité aux coordonnées pX et pY. */
    public function moveTo(pX:uint, pY:uint):void
    {
      
    }
	}
}