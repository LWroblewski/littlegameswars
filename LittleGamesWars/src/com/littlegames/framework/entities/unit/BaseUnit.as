package com.littlegames.framework.entities.unit
{
	import com.littlegames.framework.entities.unit.weapon.Weapon;
	
	/** Classe de base d'un type d'unité. */
	public class BaseUnit
	{
    /** Variable statique qui fait référence à toutes les unités. Utilisé notamment pour l'application des bonus sur toutes les unités. */
    public static const ALL:String = "all";
    // ------------------------------------------------------------------------
    /** Identifiant de l'unitée */
    public var unitId:uint = 0;
		/** Nom de l'unité */
		protected var _name:String;
		/** Coût de déploiement. */
		protected var _costDeployment:uint;
		/** Coût de réparation/jour. */
		protected var _costRepair:uint;
		/** Mouvement (nombre de cases de déplacement) par défaut. */
		protected var _movement:uint;
		/** Type de mouvement. */
		protected var _movementType:String;
		/** Champ de vision (pour le brouillard de guerre). */
		protected var _visionRange:uint;
		/** Carburant. */
		protected var _fuel:uint;
		/** Arme principale. */
		protected var _weaponPrimary:Weapon;
		/** Arme secondaire. */
		protected var _weaponSecondary:Weapon;
		
    /** Constructeur */
		public function BaseUnit(pName:String, pCostDeploy:uint, pCostRepair:uint, pMove:uint, pMoveType:String, pRange:uint, pFuel:uint, pPrimary:Weapon, pSecondary:Weapon = null)
		{
			_name = pName;
			_costDeployment = pCostDeploy;
			_costRepair = pCostRepair;
			_movement = pMove;
			_movementType = pMoveType;
			_visionRange = pRange;
			_fuel = pFuel;
			_weaponPrimary = pPrimary;
			_weaponSecondary = pSecondary;
		}
	}
}