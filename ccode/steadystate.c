/*	this is a file in the VAc dynamic model software package
 *	this is the file for the steady state process data in the basic operating mode (not optimized)
 *	parent-routine: VAmodel.c
 *	Copyright: Rong Chen and Kedar Dave, June 2002
 *	VERSION 1.0
 */
 
/*	
 *	Modified by Alexander Isakov on 2014
 *	version 1.1
 *	:Added steadyMVS & steadySTS
 *	
 *	Copyright © 2014 Alexander Isakov. Contact: <alexander.isakov@tuhh.de>
 *	Copyright © 2014 Marina Krotofil. Contact: <marina.krotofil@tuhh.de>
 *	Copyright © 2014 TUHH-SVA Security in Distributed Applications.
 * 	All rights reserved.
 *	License: http://opensource.org/licenses/BSD-3-Clause
 *	---------------------------------------------------------------------
 */	

#include <stdio.h>
#include <math.h>

void steadystate(double MVS[], double STATES[])
{
    int i;
    double mvs[26]={
          0.52343003710111,
         0.835217268934129,
         0.790026413554696,
          21876.9877721852,
           18.728267009014,
           9008.5406935041,
          135.018391707178,
          2.75438428905024,
          36.0012295162535,
                   16.1026,
          27192.4219484591,
          1.21366689616643,
                   15.1198,
          10729.8900873211,
                     0.756,
          2018.43004751657,
          6.55307587098636,
       0.00315687443512887,
         0.313026840552122,
           4.9848844779243,
          67178.8579112547,
          60367.3972613543,
          0.829040050877669,
         0.836077056930357,
          2.15837365008457,
                    2.1924
    };
    
    double states[246] ={
      0.000663659407133395,
      0.000332732450155642,
        0.0134912199479539,
       0.00162751551202943,
        0.0271065270204093,
         0.951882997844851,
         0.699999996824111,
          119.145219885782,
        0.0175589716398125,
        0.0162929429097801,
        0.0150834006635812,
        0.0139332286281951,
        0.0128463158160867,
        0.0118263519039695,
        0.0108758835733143,
       0.00999566895667261,
       0.00918441933033151,
        0.0084389570853562,
       0.00159553696160461,
       0.00162458880807157,
       0.00166274684754579,
        0.0017062209092524,
       0.00175126306173113,
       0.00179431965646144,
        0.0018322211755343,
       0.00186236754739096,
       0.00188285688293816,
       0.00189252049871014,
         0.140819033783875,
         0.134754781991664,
          0.12903327158763,
          0.12360615867642,
         0.118440144936224,
         0.113509157452373,
         0.108788990644953,
         0.104254050243748,
         0.099876188529604,
        0.0956254359469808,
       0.00136784321300813,
       0.00234999379462041,
       0.00327584967176358,
       0.00413290171322466,
       0.00491174993955765,
       0.00560570677851114,
       0.00621051389698821,
       0.00672409205292511,
       0.00714627791095438,
       0.00747853616589494,
       0.00318437552973624,
       0.00418774557402648,
        0.0051443768726401,
        0.0060378731408602,
       0.00685501757742005,
       0.00758551558109247,
       0.00822189285800267,
       0.00875942531335696,
        0.0091960024956991,
       0.00953187545645922,
        0.0255550841888396,
        0.0236187475024977,
         0.021793498578692,
        0.0200800315537184,
        0.0184793537862666,
        0.0169916497340827,
        0.0156155197925629,
        0.0143475877037275,
        0.0131825069898176,
        0.0121133356791918,
          152.515501748242,
          155.641592023486,
          158.015939863408,
           159.73262963317,
           160.85183921479,
          161.417694492952,
          161.472975701556,
          161.069917928174,
          160.275450900194,
          159.169995766986,
       0.00132380406401621,
      0.000719612261903781,
        0.0236372995127054,
         0.174008547825989,
         0.334038451182119,
         0.456451002498642,
         0.500046419718972,
          39.9999988383099,
        0.0569465492045698,
        0.0126985233423726,
         0.643808436634138,
        0.0209017186689456,
       0.00743940828211637,
       0.00398954930049825,
          84.2519845772682,
          41.0012287591771,
       0.00126828905962982,
       0.00128403831066931,
        0.0010136884642688,
      0.000950312133226393,
      0.000931584631849887,
      0.000918819492877675,
       0.00090593863273761,
      0.000891015112493328,
      0.000917400271826095,
      0.000924586355608594,
      0.000799401296569979,
      0.000767258962839511,
      0.000753759239015543,
      0.000743904564497274,
      0.000734233796173805,
      0.000722036192308671,
        0.0259513974177929,
        0.0272833807330475,
        0.0223547022666141,
        0.0212170812606176,
        0.0207925863280729,
         0.020482612444623,
        0.0201776448585294,
        0.0199095449822689,
         0.255554217009127,
         0.254570175421162,
         0.142827718835525,
         0.111241714052836,
        0.0876375405894624,
        0.0694647126836213,
        0.0524258536179032,
        0.0325036209994564,
         0.129127357377499,
         0.125762009872873,
        0.0741286897275229,
        0.0594192297171773,
        0.0604303190638807,
        0.0622188868900966,
        0.0636812502036909,
         0.065395390490694,
         0.576778642679934,
         0.579234099392294,
         0.750018257267289,
         0.798023710798955,
         0.821243597976687,
         0.838083598390124,
         0.854109180620964,
         0.872719450601011,
          13.6084339670806,
          13.6061145578899,
          13.6068981796877,
          13.6066292515065,
          13.6079016059848,
          13.6073496310857,
          13.6076729839204,
          13.6075910770526,
          47.8987514441403,
          35.1279984080967,
          39.0133484644232,
          39.2355888214155,
            39.70693699704,
          40.2031532587549,
          40.6647299086819,
          39.6960239415672,
       0.00126828905855437,
      0.000917400290598044,
        0.0259513993773912,
         0.255554230775313,
         0.129127360768626,
         0.576778624920724,
         0.499946538488202,
          47.8987516921869,
     5.55839747640732e-005,
      0.000276708140287114,
       0.00144598318785804,
       0.00837754598891844,
        0.0505364673088945,
         0.226382222105162,
         0.447991466512184,
         0.530995397736738,
         0.555910888115674,
         0.564809573155954,
          0.56882919324755,
          0.57114460340736,
         0.572803782917262,
         0.574200214532656,
         0.575495385413331,
         0.805783827190703,
         0.880403477943325,
         0.906875683571773,
           0.9184060942439,
          0.92599255852643,
         0.806269830806122,
         0.672900931578798,
         0.550686777995853,
         0.470472677932738,
         0.419202664992037,
         0.347968715736377,
         0.269611659810616,
         0.243074248379238,
         0.237878819499972,
         0.237261167498344,
         0.237433332635326,
         0.237685764504895,
         0.237917513711896,
         0.238129770517882,
         0.238333033291516,
        0.0775672581141022,
        0.0268791043104891,
       0.00966301925493509,
       0.00347298767319165,
        0.0011971531531783,
          2.64109552188728,
          2.55082805050048,
          2.48144065400843,
          2.43735186419207,
          2.40256883580744,
          2.39176741421249,
          2.42649648114181,
          2.44573720385547,
          2.45121159989488,
          2.45231329683537,
          2.45185115757585,
          2.45074398149757,
          2.44934331576837,
          2.44779485561834,
          2.44616086713232,
          2.37268484694175,
          2.37511835481015,
          2.37516769486192,
          2.37504695877361,
          2.37522269207844,
     1.08213392363876e-005,
         0.906549438617103,
         0.500007499269263,
         0.949785850539446,
      0.000351974228354218,
         0.499985183304765,
       0.00240452114142709,
      0.000351973887173725,
         0.499986567556951,
     7.92174932346166e-006,
         0.931589602930866,
         0.500018753056283,
          109.773605988319,
                       150,
                        80,
                        25,
                        25,
          45.8449999779885,
          97.1009365439832,
          133.999999835572
    };
    
    for (i=0;i<26;i++)
    MVS[i]=mvs[i];
    for (i=0;i<246;i++)
    STATES[i]=states[i];

/* 43 measurements: for illustration
          128.000020494557
         0.699999996824092
          119.145219885839
                       150
          159.169995767005
          18.8569842555798
          97.1009365441301
          133.999999835572
         0.500046419719699
          39.9999988383066
                        80
          128.000020534259
         0.499946538490609
                        25
                        25
          16.5358670094204
         0.829040051085384
         0.499985183310527
         0.499986567562218
          45.8449999779885
         0.500007499266365
           110.00000014934
          0.50001875304899
         0.949785850539478
         0.049862175232202
      0.000351974228319671
     1.08213392344539e-005
        0.0934397400433462
         0.906549438617419
        0.0556636831729143
       0.00730377053828736
         0.681207987501763
         0.249190898442788
       0.00159745660941687
       0.00089415043880772
       0.00414205329602229
        0.0750000010759696
       0.00627343023351608
         0.585110220089934
         0.214037626808648
       0.00137300616286567
       0.00855774591434233
         0.109647969714724
*/    
}

void steadyMVS(double MVS[])
{
	double states[246];
	steadystate(MVS, states);
}

void steadySTS(double STATES[])
{
	double mvs[26];
	steadystate(mvs, STATES);
}
