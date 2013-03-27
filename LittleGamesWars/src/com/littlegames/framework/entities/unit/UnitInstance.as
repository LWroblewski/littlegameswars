package com.littlegames.framework.entities.unit
{
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.Utils;
  
  import starling.display.MovieClip;
	
	/** Occurence d'une unité. */
	public class UnitInstance
	{
    /** Max HPs d'une unité */
		public static const MAX_HP:uint = 10;
		
		/** Type de l'unité. */
		protected var _unit:Unit;
		
		/** Points de vie courants (10 au maximum). */
		protected var _hp:uint;
		
		/** Position x sur la map. */
		protected var _x:uint;
		
		/** Position y sur la map. */
		protected var _y:uint;
    
    /** Indique si l'unité peut agir ou non */
    protected var _enabled:Boolean;
    
    public function get enabled():Boolean
    {
      return _enabled;
    }
    
    public function set enabled(pValue:Boolean):void
    {
      if (_enabled != pValue)
      {
        _enabled = pValue;
        
        //Mise à jour du movieClip associé.
        if (_unitMovieClip)
        {
          _unitMovieClip = Resources.replace(_unitMovieClip, _enabled ? Animations.LEFT : Animations.DISABLED);
        }
      }
    }
		
    /** MovieClip associé à l'unité. */
    private var _unitMovieClip:MovieClip;
    
		public function UnitInstance(pUnit:Unit, pHp:uint = MAX_HP, pX:uint = 0, pY:uint = 0, pEnabled:Boolean = false)
		{
      _unit = pUnit;
			_hp = pHp;
      _x = pX;
      _y = pY;
      enabled = pEnabled;
		}
    
    /** Création du movieClip associé à l'unité, et ajout à la map aux coordonnées pX et pY. */
    public function addToMap(pX:uint = 0, pY:uint = 0):void
    {
      try
      {
        _unitMovieClip = Resources.add((Utils.getClass(_unit)).ID + "_" + Animations.LEFT);
      }
      catch (error:Error)
      {
        throw new Error("Votre classe d'unité doit contenir une propriété prublique statique nommée ID.");
      }
    }
    
    /** Suppression du movieClip. */
    public function remove():void
    {
      if (_unitMovieClip)
      {
        Resources.remove(_unitMovieClip);
      }
    }
    
    /** Déplacement de l'unité aux coordonnées pX et pY. */
    public function moveTo(pX:uint, pY:uint):void
    {
      if (_unitMovieClip)
      {
        //_unitMovieClip.x = pX;
        //_unitMovieClip.y = pY;
      }
    }
    
    public function render():void
    {
      
    }
	}
}