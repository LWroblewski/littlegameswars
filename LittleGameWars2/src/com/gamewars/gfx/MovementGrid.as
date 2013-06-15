package com.gamewars.gfx
{
  import com.gamewars.enums.WindRose;
  import com.gamewars.structures.Tile;
  import com.gamewars.structures.Unit;
  import com.gamewars.utils.Resources;
  import com.gamewars.utils.pathfinding.PathFinding;
  import com.gamewars.utils.pathfinding.PathNode;
  import com.gamewars.utils.pathfinding.PathResult;
  import com.gamewars.world.World;
  import com.gamewars.world.WorldCell;
  
  import flash.display3D.textures.Texture;
  import flash.utils.Dictionary;
  
  import starling.core.Starling;
  import starling.display.DisplayObject;
  import starling.display.Image;
  import starling.display.MovieClip;
  import starling.display.Sprite;
  
  public class MovementGrid extends Sprite
  {
    /** Réference vers le monde */
    private var mWorld:World;
    
    /** Layers */
    private var mGridLayer:Sprite;
    private var mArrowLayer:Sprite;
    
    /** Constructeur */
    public function MovementGrid(pWorld:World)
    {
      super();
      mWorld = pWorld;
      
      mGridLayer = new Sprite();
      addChild(mGridLayer);
      mArrowLayer = new Sprite();
      addChild(mArrowLayer);
    }
    
    /** Effectue un rendu spécial sur toutes les cases passées en paramètres */
    public function renderOnCells(pCells:Vector.<WorldCell>, pRenderFunction:Function) : void
    {
      mGridLayer.removeChildren();
      for each (var cell:WorldCell in pCells)
      {
        var renderer:DisplayObject = pRenderFunction(cell);
        if (renderer != null)
          mGridLayer.addChild(renderer);
      }
    }
    
    // TODO Revoir l'implémentation de la fonction
    /** Affiche la flèche de déplacement d'une cellule à une autre */
    public function renderArrow(pNode:PathNode) : void
    {
      mArrowLayer.removeChildren();
      var allNodes:Vector.<PathNode> = new <PathNode>[];
      while (pNode != null)
      {
        allNodes.push(pNode);
        pNode = pNode.mParent;
      }
      allNodes = allNodes.reverse();
      
      if (allNodes.length <= 1)
        return;
      
      // Direction initiale de la flèche
      var currentDir:WindRose = WindRose.SOUTH;
      var nextDir:WindRose = WindRose.SOUTH;
      var pi:Number = Math.PI;
      for (var i:uint = 0; i < allNodes.length; i++)
      {
        currentDir = nextDir;
        var current:PathNode = allNodes[i];
        var isLast:Boolean = i == allNodes.length-1;
        var rot:Number = 0;
        // Récupère la direction du prochain noeud
        if (!isLast)
        {
          var next:PathNode = allNodes[i+1];
          nextDir = current.mCell.getDirection(next.mCell);
          // Si premier noeud, on oriente bien le départ
          if (i == 0)
          {
            currentDir = nextDir;
          }
        }
        // Crée le renderer
        var texIdx:uint = 0;
        if (isLast)
        {
          // Flèche
          texIdx = 2;
          if (currentDir == WindRose.EAST)
            rot = 0;
          else if (currentDir == WindRose.SOUTH)
            rot = pi/2;
          else if (currentDir == WindRose.WEST)
            rot = pi;
          else if (currentDir == WindRose.NORTH)
            rot = -pi/2;
        }
        else if (currentDir != nextDir)
        {
          // Joint
          texIdx = 1;
          
          // Gauche vers bas
          // Bas vers gauche
          if (currentDir == WindRose.EAST && nextDir == WindRose.SOUTH ||
            currentDir == WindRose.NORTH && nextDir == WindRose.WEST)
          {
            rot = 0;
          }
          // Haut vers gauche
          // Gauche vers haut
          else if (currentDir == WindRose.SOUTH && nextDir == WindRose.WEST ||
            currentDir == WindRose.EAST && nextDir == WindRose.NORTH)
          {
            rot = pi/2;
          }
          // Droite vers haut
          // Haut vers droite
          else if (currentDir == WindRose.WEST && nextDir == WindRose.NORTH ||
            currentDir == WindRose.SOUTH && nextDir == WindRose.EAST)
          {
            rot = pi;
          }
          // Bas vers droite
          // Droite vers bas
          else if (currentDir == WindRose.NORTH && nextDir == WindRose.EAST ||
            currentDir == WindRose.WEST && nextDir == WindRose.SOUTH)
          {
            rot = -pi/2;
          }
        }
        else
        {
          // Droit
          texIdx = 0;
          rot = [WindRose.WEST, WindRose.EAST].indexOf(currentDir) == -1 ? pi/2 : 0;
        }

        // Pas de rendu pour la première case
        if (i == 0)
          continue;
        // Crée le rendu
        var sp:Image = new Image(Resources.getGuiTexs('Arrow')[texIdx]);
        sp.rotation = rot;
        sp.pivotX = Tile.TILE_SIZE/2;
        sp.pivotY = Tile.TILE_SIZE/2;
        sp.x = current.mCell.mPosition.xOffset + Tile.TILE_SIZE/2;
        sp.y = current.mCell.mPosition.yOffset + Tile.TILE_SIZE/2;
        mArrowLayer.addChild(sp);
      }
    }
    
    /** Nettoie la grille */
    public function clearGrid() : void
    {
      mArrowLayer.removeChildren();
      mGridLayer.removeChildren();
    }
  }
}