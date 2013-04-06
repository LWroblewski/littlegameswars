package com.littlegames.framework.entities.unit
{
  import com.littlegames.framework.entities.unit.MovementType;
  import com.littlegames.framework.entities.unit.UnitType;
  import com.littlegames.framework.entities.unit.weapon.listing.Bazooka;
  import com.littlegames.framework.entities.unit.weapon.listing.Cannon;
  import com.littlegames.framework.entities.unit.weapon.listing.MachineGun;
  import com.littlegames.framework.entities.unit.weapon.listing.MegaGun;
  import com.littlegames.framework.entities.unit.weapon.listing.TankGun;
  import com.littlegames.framework.entities.unit.weapon.listing.VulcanCannon;
  import com.littlegames.framework.utils.HashMap;

  public class Units
  {
    public static const ALL:String = "all";
    public static const ANTI_AIR:UnitType = new UnitType("antiair", "Anti-Air", 7000, 700, 6, MovementType.TREAD, 3, 60, new VulcanCannon());
    public static const ARTILLERY:UnitType = new UnitType("artillery", "Artillery", 6000, 600, 5, MovementType.TREAD, 3, 50, new Cannon());
    public static const BATTLE_COPTER:UnitType;
    public static const BATTLE_SHIP:UnitType;
    public static const BIKE:UnitType = new UnitType("bike1", "Bike", 2500, 250, 5, MovementType.TIRES_LIGHT, 2, 99, new MachineGun());
    public static const CARRIER:UnitType;
    public static const CRUISER:UnitType;
    public static const FLARE:UnitType = new UnitType("flare", "Flare", 5000, 500, 5, MovementType.TREAD, 3, 60, new MachineGun());
    public static const GUN_BOAT:UnitType;
    public static const INFANTRY:UnitType = new UnitType("infantry1", "Infanterie", 1000, 100, 3, MovementType.INFANTRY, 2, 99, new MachineGun());
    public static const LANDER:UnitType;
    public static const MECH:UnitType = new UnitType("mech1", "Mech", 3000, 300, 2, MovementType.INFANTRY, 2, 70, new MachineGun(), new Bazooka());
    public static const MEDIUM_TANK:UnitType;
    public static const MISSILES:UnitType;
    public static const RECON:UnitType = new UnitType("recon", "Recon", 4000, 400, 8, MovementType.TIRES, 5, 80, new MachineGun());
    public static const RIG:UnitType = new UnitType("rig", "Génie", 5000, 500, 6, MovementType.TREAD, 1, 99, null);
    public static const ROCKETS:UnitType = new UnitType("rockets", "Lance-roquettes", 15000, 1500, 5, MovementType.TIRES, 3, 50, null);
    public static const SUBMARINE:UnitType;
    public static const TANK:UnitType = new UnitType("tank", "Tank", 7000, 700, 6, MovementType.TREAD, 3, 70, new TankGun(), new MachineGun());
    public static const TRANSPORT_COPTER:UnitType;
    public static const WAR_TANK:UnitType = new UnitType("wartank", "Méga tank", 16000, 1600, 4, MovementType.TREAD, 2, 50, new MegaGun(), new MachineGun());
  }
}