package com.littlegames.framework.core.data
{
	import com.littlegames.framework.entities.building.BaseBuilding;
	import com.littlegames.framework.entities.co.Commander;
	import com.littlegames.framework.entities.unit.UnitInstance;
	
	/** Joueur. */
	public class Player
	{
    /** Id du joueur (login pour joueur physique, null pour IA). */
    public var id:String;
    /** Liste des COs disponibles pour le joueur (uniquement pour joueur physique). */
    public var availablesCos:Vector.<Commander>;
		/** Commandant choisi par le joueur. */
		public var commander:Commander;
		/** Liste des unités du joueur. */
		public var units:Vector.<UnitInstance>;
    /** Liste des buildings capturés par le joueur. */
    public var buildings:Vector.<BaseBuilding>;
		/** Argent du joueur. */
		public var gold:uint;
		
    /** Constructeur */
		public function Player(
      pId:String = null, 
      pCO:Commander = null, 
      pGold:uint = 0, 
      pUnits:Vector.<UnitInstance> = null, 
      pBuildings:Vector.<BaseBuilding> = null)
		{
      id = pId;
      commander = pCO;
      gold = pGold;
      units = pUnits ? pUnits : new Vector.<UnitInstance>;
      buildings = pBuildings ? pBuildings : new Vector.<BaseBuilding>;
		}
    
    /** Initialisation d'un nouveau tour de jeu pour le joueur. */
    public function initNewTurn():void
    {
      //Récupération des revenus des bâtiments.
      for each (var building:BaseBuilding in buildings)
      {
        gold += building.income;
      }
      
      //Activation des unités.
      for each (var unit:UnitInstance in units)
      {
        unit.enabled = true;
      }
    }
	}
}