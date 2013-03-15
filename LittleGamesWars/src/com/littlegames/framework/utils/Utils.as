package com.littlegames.framework.utils
{
  import flash.utils.getDefinitionByName;
  import flash.utils.getQualifiedClassName;

  /** Fonctions utilitaires */
  public class Utils
  {
    /** Récupération de la classe de l'objet pObject. */
    public static function getClass(pObject:Object):Class 
    {
      return Class(getDefinitionByName(getQualifiedClassName(pObject)));  
    }
    
    
  }
}