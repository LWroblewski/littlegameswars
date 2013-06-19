package com.gamewars.core
{
  import com.gamewars.managers.FogManager;
  import com.gamewars.structures.Unit;
  import com.gamewars.world.World;

  public class GameEngine
  {
    /** Réference vers le monde */
    private var mWorld:World;
    /** Gestion du brouillard */
    public var mFogManager:FogManager;
    /** Sytème de rendu */
    public var mRenderSystem:RenderSystem;
    
    /** Constructeur */
    public function GameEngine(pWorld:World)
    {
      mWorld = pWorld;
      // Brouillard
      mFogManager = new FogManager(pWorld, pWorld.mFogLayer);
      mFogManager.displayFog(false);
      mRenderSystem = new RenderSystem();
      mRenderSystem.initialize(pWorld);
    }
    
    /** Calcul les résultats du combat entre 2 unitées */
    public function processFight(pUnit:Unit, pTarget:Unit) : void
    {
      pTarget.mHp -= pUnit.mUnitType.mAttack;
      if (pTarget.mHp <= 0)
      {
        killUnit(pTarget);
      }
    }
    
    /** Mort de l'unitée */
    public function killUnit(pUnit:Unit) : void
    {
      // Remove target from world
      mWorld.removeUnit(pUnit);
      pUnit.mOwner.removeUnit(pUnit);
      // Explosion de l'unité
    }
  }
}