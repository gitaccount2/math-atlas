/* This file generated by /home/cborntra/REPOS/ATLAS/build/..//tune/blas/gemm/txover.c
 */
#ifndef ATL_TXOVER_H
   #define ATL_TXOVER_H 1

   #define ATL_PDIM 2
static const int ATL_tmmNN_SQmnk_XO[2] = 
   {160,166};
static const int ATL_tmmNT_SQmnk_XO[2] = 
   {160,166};
static const int ATL_tmmTN_SQmnk_XO[2] = 
   {160,166};
#define ATL_tmmTT_SQmnk_XO ATL_tmmNN_SQmnk_XO
static const int *ATL_tmm_SQmnk_XO[4] =
{ATL_tmmNN_SQmnk_XO, ATL_tmmNT_SQmnk_XO,
 ATL_tmmTN_SQmnk_XO, ATL_tmmTT_SQmnk_XO};
static const int ATL_tmmNN_SmnLk_XO[18] = 
   {3152,0,1740,2400,1441,2890,450,888,171,499,171,320,171,320,171,325,0,80};
static const int ATL_tmmNT_SmnLk_XO[18] = 
   {1976,3754,1384,1942,1367,2608,0,574,171,320,171,320,171,320,171,325,0,80};
static const int ATL_tmmTN_SmnLk_XO[18] = 
   {0,0,2242,3682,1762,3840,474,613,170,329,170,329,170,329,170,322,0,80};
#define ATL_tmmTT_SmnLk_XO ATL_tmmNN_SmnLk_XO
static const int *ATL_tmm_SmnLk_XO[4] =
{ATL_tmmNN_SmnLk_XO, ATL_tmmNT_SmnLk_XO,
 ATL_tmmTN_SmnLk_XO, ATL_tmmTT_SmnLk_XO};
static const int ATL_tmmNN_SmkLn_XO[18] = 
   {2465,3160,0,2366,1441,2194,0,818,170,329,170,329,170,329,170,322,80,160};
static const int ATL_tmmNT_SmkLn_XO[18] = 
   {2664,4730,1727,3428,1161,1973,489,852,170,522,170,329,170,329,170,322,80,160};
#define ATL_tmmTN_SmkLn_XO ATL_tmmNN_SmkLn_XO
#define ATL_tmmTT_SmkLn_XO ATL_tmmNT_SmkLn_XO
static const int *ATL_tmm_SmkLn_XO[4] =
{ATL_tmmNN_SmkLn_XO, ATL_tmmNT_SmkLn_XO,
 ATL_tmmTN_SmkLn_XO, ATL_tmmTT_SmkLn_XO};
static const int ATL_tmmNN_SnkLm_XO[18] = 
   {0,0,5783,0,1386,2647,498,590,170,329,170,329,170,329,170,322,80,160};
#define ATL_tmmNT_SnkLm_XO ATL_tmmNN_SnkLm_XO
static const int ATL_tmmTN_SnkLm_XO[18] = 
   {5251,0,2576,4835,1032,1292,368,567,170,329,170,329,170,329,170,322,80,160};
#define ATL_tmmTT_SnkLm_XO ATL_tmmTN_SnkLm_XO
static const int *ATL_tmm_SnkLm_XO[4] =
{ATL_tmmNN_SnkLm_XO, ATL_tmmNT_SnkLm_XO,
 ATL_tmmTN_SnkLm_XO, ATL_tmmTT_SnkLm_XO};
static const int ATL_tmmNN_SmLnk_XO[18] = 
   {171,858,171,424,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmNT_SmLnk_XO[18] = 
   {0,320,0,320,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmTN_SmLnk_XO[18] = 
   {171,858,171,424,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmTT_SmLnk_XO[18] = 
   {171,320,171,320,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int *ATL_tmm_SmLnk_XO[4] =
{ATL_tmmNN_SmLnk_XO, ATL_tmmNT_SmLnk_XO,
 ATL_tmmTN_SmLnk_XO, ATL_tmmTT_SmLnk_XO};
static const int ATL_tmmNN_SnLmk_XO[18] = 
   {0,410,0,410,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmNT_SnLmk_XO[18] = 
   {0,325,0,325,282,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmTN_SnLmk_XO[18] = 
   {0,410,0,410,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int ATL_tmmTT_SnLmk_XO[18] = 
   {171,320,171,320,171,320,171,320,171,320,171,320,171,320,171,325,80,171};
static const int *ATL_tmm_SnLmk_XO[4] =
{ATL_tmmNN_SnLmk_XO, ATL_tmmNT_SnLmk_XO,
 ATL_tmmTN_SnLmk_XO, ATL_tmmTT_SnLmk_XO};
static const int ATL_tmmNN_SkLmn_XO[18] = 
   {0,171,0,171,0,171,0,171,0,171,0,171,0,171,171,171,80,171};
static const int ATL_tmmNT_SkLmn_XO[18] = 
   {0,171,0,171,0,171,0,171,0,171,0,171,0,171,171,171,80,171};
static const int ATL_tmmTN_SkLmn_XO[18] = 
   {0,171,0,171,0,171,0,171,0,171,0,171,0,171,171,171,80,171};
#define ATL_tmmTT_SkLmn_XO ATL_tmmNN_SkLmn_XO
static const int *ATL_tmm_SkLmn_XO[4] =
{ATL_tmmNN_SkLmn_XO, ATL_tmmNT_SkLmn_XO,
 ATL_tmmTN_SkLmn_XO, ATL_tmmTT_SkLmn_XO};

#endif /* end ifndef ATL_TXOVER_H */
