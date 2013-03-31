package com.littlegames.framework.entities.building
{
  import com.littlegames.framework.resources.Animations;
  import com.littlegames.framework.resources.Resources;
  import com.littlegames.framework.utils.Utils;
  
  import starling.display.MovieClip;

	/** Bâtiment générique. */
	public class BaseBuilding
	{
    /** Revenu par défaut des bâtiments. */
    private static const DEFAULT_BUILDING_INCOME:uint = 1000;
		/** Clé utilisée pour la reconnaissance du building dans les maps. */
		public static const ALL:String = "All";
    // ------------------------------------------------------------------------
		/** Nom du bâtiment. */
		public var name:String;
    /** movieClip du bâtiment. */
    public var movieClip:MovieClip;
    /** Argent reçu chaque tour en possédant ce bâtiment. */
    public var income:uint;

    /** Constructeur */
		public function BaseBuilding(pName:String, pIncome:uint = DEFAULT_BUILDING_INCOME)
		{
      name = pName;
      income = pIncome;
		}
    
    /** Création du movieClip associé au bâtiment, et ajout à la map aux coordonnées pX et pY. */
    public function addToMap(pX:uint = 0, pY:uint = 0):void
    {
      try
      {
        movieClip = Resources.add((Utils.getClass(this)).ID);
      }
      catch (error:Error)
      {
        throw new Error("Votre classe d'unité doit contenir une propriété publique statique nommée ID.");
      }
    }
    
    /** Suppression du movieClip. */
    public function remove():void
    {
      if (movieClip)
      {
        Resources.remove(movieClip);
      }
    }
	}
}