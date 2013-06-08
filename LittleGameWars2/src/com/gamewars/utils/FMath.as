package com.gamewars.utils
{

  /** Utilitaires de calculc */
  public class FMath
  {
    /** Calcul de l'interpolation linéaire de deux points */
    public static function interp_linear(x1:Number, x2:Number, pVal:Number):Number
    {
      return x1 + (x2 - x1) * pVal;
    }
  }
}
