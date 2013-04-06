package com.littlegames.framework.entities.unit
{
	import com.littlegames.framework.entities.unit.weapon.Weapon;
	
	/** Classe de base d'un type d'unité. */
	public class UnitType
	{
    /** Vitesse de capture des bâtiments par défaut. */
    public static const DEFAULT_CAPTURE_SPEED:uint = 5;
    
    /** Identifiant (notamment pour la spritesheet) */
    protected var _id:String;
    
    public function get id():String
    {
      return _id;
    }
    
		/** Nom de l'unité */
		protected var _name:String;
    
    public function get name():String
    {
      return _name;
    }
    
		/** Coût de déploiement. */
		protected var _costDeployment:uint;
    
    public function get costDeployment():uint
    {
      return _costDeployment;
    }
    
		/** Coût de réparation/jour. */
		protected var _costRepair:uint;
    
    public function get costRepair():uint
    {
      return _costRepair;
    }
    
		/** Mouvement (nombre de cases de déplacement) par défaut. */
		protected var _movement:uint;
    
    public function get movement():uint
    {
      return _movement;
    }
    
		/** Type de mouvement. */
		protected var _movementType:String;
    
    public function get movementType():String
    {
      return _movementType;
    }
    
		/** Champ de vision (pour le brouillard de guerre). */
		protected var _visionRange:uint;
    
    public function get visionRange():uint
    {
      return _visionRange;
    }
    
		/** Carburant. */
		protected var _fuel:uint;
    
    public function get fuel():uint
    {
      return _fuel;
    }
    
		/** Arme principale. */
		protected var _weaponPrimary:Weapon;
    
    public function get weaponPrimary():Weapon
    {
      return _weaponPrimary;
    }
    
		/** Arme secondaire. */
		protected var _weaponSecondary:Weapon;
    
    public function get weaponSecondary():Weapon
    {
      return _weaponSecondary;
    }
    
    /** Défiit si l'unité peut capturer des bâtiments. */
    protected var _captureSpeed:uint;
    
    public function get captureSpeed():uint
    {
      return _captureSpeed;
    }
		
    /** Constructeur */
		public function UnitType(pId:String, pName:String, pCostDeploy:uint, pCostRepair:uint, pMove:uint, pMoveType:String, pRange:uint, pFuel:uint, pPrimary:Weapon, pSecondary:Weapon = null, pCaptureSpeed:uint = 0)
		{
      _id = pId;
			_name = pName;
			_costDeployment = pCostDeploy;
			_costRepair = pCostRepair;
			_movement = pMove;
			_movementType = pMoveType;
			_visionRange = pRange;
			_fuel = pFuel;
			_weaponPrimary = pPrimary;
			_weaponSecondary = pSecondary;
      _captureSpeed = pCaptureSpeed;
		}
	}
}