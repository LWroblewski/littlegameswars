package com.littlegames.framework.entities.building
{
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.Utils;
  
  import starling.display.MovieClip;

	/**
	 * Bâtiment générique.
	 */
	public class Building
	{
    /** Revenu par défaut des bâtiments. */
    private static const DEFAULT_BUILDING_INCOME:uint = 1000;
    
		/** Clé utilisée pour la reconnaissance du building dans les maps. */
		public static const ALL:String = "All";
		
		/** Nom du bâtiment. */
		protected var _name:String;
    
    public function get name():String
    {
      return _name;
    }
		
    /** movieClip du bâtiment. */
    protected var _movieClip:MovieClip;
    
    /** Argent reçu chaque tour en possédant ce bâtiment. */
    protected var _income:uint;
    
    public function get income():uint
    {
      return _income;
    }
    
		public function Building(pName:String, pIncome:uint = DEFAULT_BUILDING_INCOME)
		{
      _name = pName;
      _income = pIncome;
		}
    
    /** Création du movieClip associé au bâtiment, et ajout à la map aux coordonnées pX et pY. */
    public function addToMap(pX:uint = 0, pY:uint = 0):void
    {
      try
      {
        _movieClip = Resources.add((Utils.getClass(this)).ID);
      }
      catch (error:Error)
      {
        throw new Error("Votre classe d'unité doit contenir une propriété prublique statique nommée ID.");
      }
    }
    
    /** Suppression du movieClip. */
    public function remove():void
    {
      if (_movieClip)
      {
        Resources.remove(_movieClip);
      }
    }
	}
}