%let pgm=utl-sum-the-three-largest-yoy-growth-by-company-sql-partitioning-and-rank-sas-r-python-excel

  Sum the three largest yoy growth by company sql partitioning and rank sas r python excel


   CONTENTS
        1  sas sql
        2  r sql (exact same solution for python and excel)
           only presented for r same code in python and excel
           see
           https://tinyurl.com/4e6yaap8

github
https://tinyurl.com/4ztna378
https://github.com/rogerjdeangelis/utl-sum-the-three-largest-yoy-growth-by-company-sql-partitioning-and-rank-sas-r-python-excel

communities.sas
https://tinyurl.com/3r66x7cy
https://communities.sas.com/t5/SAS-Programming/how-to-find-the-sum-of-first-three-largest-shareholdings/m-p/811045#M319890

Note: Shortened length of   company and removed year becaus it is constant.
      Easy to add years.

/***************************************************************************************************************************/
/*      INPUT                             | PROCESS                                     |        OUTPUT                    */
/*      =====                             | =======                                     |       ======                     */
/*                                        |                                             |                                  */
/*    COMPANY     YOY                     | Consider Company 3M                         |  COMPANY    SUMUP3               */
/*                                        | Sorted for documentation only               |                                  */
/*      X0        0.07                    |                                             |    3I        34.75               */
/*      X0        0.10                    | COMPANY  YOY  Sum largest 3                 |    3M        80.83*              */
/*      X0        0.14                    |                                             |    3P        41.42               */
/*      3M        1.93                    |   3M    76.00                               |    X0        48.41               */
/*      X0        0.77                    |   3M     2.90 Largest 3                     |                                  */
/* ..                                     |   3M     1.93 80.83=76+2.90+1.93*           |                                  */
/*      X0       10.80                    |   3M     1.93                               |                                  */
/*      3I       23.13                    |   3M     1.48                               |                                  */
/*      X0        1.95                    |   3M     1.20                               |                                  */
/*      X0       18.94                    |                                             |                                  */
/*      3M        1.20                    |--------------------------------------------------------------------------------*/
/*                                        | 1 SAS SQL                                   |  COMPANY    SUMUP3               */
/* options validvarname=upcase ;          | ==========                                  |                                  */
/* libname sd1 "d:/sd1" ;                 |                                             |    3I        34.75               */
/* data sd1.have ;                        | proc sql;                                   |    3M        80.83               */
/*  input company$ yoy  @@ ;              |   create                                    |    3P        41.42               */
/* cards4;                                |      table prep as                          |    X0        48.41               */
/* X0 00.07  X0 00.10  X0 00.14  3M 01.93 |   select                                    |                                  */
/* X0 00.77  X0 00.00  X0 00.12  3M 01.48 |      company                                |                                  */
/* X0 02.50  X0 06.81  X0 00.08  3M 02.90 |     ,yoy                                    |                                  */
/* X0 00.57  X0 01.25  X0 00.12  3M 01.93 |   from                                      |                                  */
/* X0 00.35  X0 00.58  X0 00.21  3M 76.00 |      sd1.have                               |                                  */
/* X0 01.95  X0 00.18  X0 01.95  3P 04.87 |   order                                     |                                  */
/* X0 01.85  X0 00.18  X0 06.81  3P 01.20 |     by company, yoy descending              |                                  */
/* X0 00.10  X0 01.05  X0 00.06  3P 05.56 | ;                                           |                                  */
/* X0 00.50  X0 00.36  X0 01.19  3P 02.11 |   create                                    |                                  */
/* X0 10.76  X0 01.39  X0 00.58  3P 04.58 |     table want as                           |                                  */
/* X0 00.37  X0 00.07  X0 01.05  3P 02.24 |   select                                    |                                  */
/* X0 00.01  X0 00.64  X0 01.39  3P 00.34 |     company                                 |                                  */
/* X0 09.26  X0 00.07  X0 00.33  3P 02.74 |    ,sum(yoy) as sumup3                      |                                  */
/* X0 00.61  X0 00.33  3I 02.73  3P 03.47 |   from                                      |                                  */
/* X0 00.13  X0 00.17  3I 01.39  3P 04.59 |     %sqlpartition(prep,by=company)          |                                  */
/* X0 00.14  X0 18.67  3I 01.59  3P 21.92 |   where                                     |                                  */
/* X0 00.08  X0 01.65  3I 08.12  3P 02.04 |     partition <= 3                          |                                  */
/* X0 00.12  X0 00.77  3I 02.57  3P 04.65 |   group                                     |                                  */
/* X0 00.03  X0 02.50  3I 01.75  3P 03.58 |     by company                              |                                  */
/* X0 01.65  X0 00.57  3I 02.07  3P 13.94 | ;quit;                                      |                                  */
/* X0 00.21  X0 00.35  3I 03.50           |                                             |                                  */
/* X0 00.03  X0 01.95  3I 01.90           |--------------------------------------------------------------------------------*/
/* X0 00.04  X0 01.85  3I 02.07           | 2 R SQL same code Python Excel              |  R                               */
/* X0 00.03  X0 10.80  3I 23.13           | ==============================              |  company sumup3                  */
/* X0 01.95  X0 18.94  3M 01.20           |                                             |       3I  34.75                  */
/* ;;;;                                   | proc datasets lib=sd1 nolist nodetails;     |       3M  82.76                  */
/* run;quit;                              |  delete want;                               |       3P  41.42                  */
/*                                        | run;quit;                                   |       X0  48.41                  */
/*                                        |                                             |                                  */
/*                                        | %utl_rbeginx;                               |  SAS                             */
/*                                        | parmcards4;                                 |  COMPANY    SUMUP3               */
/*                                        | library(haven)                              |                                  */
/*                                        | library(sqldf)                              |    3I        34.75               */
/*                                        | source("c:/oto/fn_tosas9x.R")               |    3M        82.76               */
/*                                        | options(sqldf.dll = "d:/dll/sqlean.dll")    |    3P        41.42               */
/*                                        | have<-read_sas("d:/sd1/have.sas7bdat")      |    X0        48.41               */
/*                                        | print(have)                                 |                                  */
/*                                        | want<-sqldf('                               |                                  */
/*                                        |   with                                      |                                  */
/*                                        |     prep as (                               |                                  */
/*                                        |   select                                    |                                  */
/*                                        |     company                                 |                                  */
/*                                        |    ,yoy                                     |                                  */
/*                                        |    ,rank() over (                           |                                  */
/*                                        |         partition by company                |                                  */
/*                                        |         order by yoy desc                   |                                  */
/*                                        |     ) as rank                               |                                  */
/*                                        |  from                                       |                                  */
/*                                        |     have )                                  |                                  */
/*                                        |  select                                     |                                  */
/*                                        |     company                                 |                                  */
/*                                        |    ,sum(yoy) as sumup3                      |                                  */
/*                                        |  from                                       |                                  */
/*                                        |     prep                                    |                                  */
/*                                        |  where                                      |                                  */
/*                                        |     rank <= 3                               |                                  */
/*                                        |  group                                      |                                  */
/*                                        |     by company                              |                                  */
/*                                        | ')                                          |                                  */
/*                                        | want                                        |                                  */
/*                                        | fn_tosas9x(                                 |                                  */
/*                                        |       inp    = want                         |                                  */
/*                                        |      ,outlib ="d:/sd1/"                     |                                  */
/*                                        |      ,outdsn ="want"                        |                                  */
/*                                        |      )                                      |                                  */
/*                                        | ;;;;                                        |                                  */
/*                                        | %utl_rendx;                                 |                                  */
/*                                        |                                             |                                  */
/*                                        | proc print data=sd1.want;                   |                                  */
/*                                        | run;quit;                                   |                                  */
/***************************************************************************************************************************/

/*                   _
(_)_ __  _ __  _   _| |_
| | `_ \| `_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
*/

options validvarname=upcase ;
libname sd1 "d:/sd1" ;
data sd1.have ;
 input company$ yoy  @@ ;
cards4;
X0 00.07  X0 00.10  X0 00.14  3M 01.93
X0 00.77  X0 00.00  X0 00.12  3M 01.48
X0 02.50  X0 06.81  X0 00.08  3M 02.90
X0 00.57  X0 01.25  X0 00.12  3M 01.93
X0 00.35  X0 00.58  X0 00.21  3M 76.00
X0 01.95  X0 00.18  X0 01.95  3P 04.87
X0 01.85  X0 00.18  X0 06.81  3P 01.20
X0 00.10  X0 01.05  X0 00.06  3P 05.56
X0 00.50  X0 00.36  X0 01.19  3P 02.11
X0 10.76  X0 01.39  X0 00.58  3P 04.58
X0 00.37  X0 00.07  X0 01.05  3P 02.24
X0 00.01  X0 00.64  X0 01.39  3P 00.34
X0 09.26  X0 00.07  X0 00.33  3P 02.74
X0 00.61  X0 00.33  3I 02.73  3P 03.47
X0 00.13  X0 00.17  3I 01.39  3P 04.59
X0 00.14  X0 18.67  3I 01.59  3P 21.92
X0 00.08  X0 01.65  3I 08.12  3P 02.04
X0 00.12  X0 00.77  3I 02.57  3P 04.65
X0 00.03  X0 02.50  3I 01.75  3P 03.58
X0 01.65  X0 00.57  3I 02.07  3P 13.94
X0 00.21  X0 00.35  3I 03.50
X0 00.03  X0 01.95  3I 01.90
X0 00.04  X0 01.85  3I 02.07
X0 00.03  X0 10.80  3I 23.13
X0 01.95  X0 18.94  3M 01.20
;;;;
run;quit;

/***************************************************************************************************************************/
/*    COMPANY     YOY                                                                                                      */
/*                                                                                                                         */
/*      X0        0.07                                                                                                     */
/*      X0        0.10                                                                                                     */
/*      X0        0.14                                                                                                     */
/*      3M        1.93                                                                                                     */
/*      X0        0.77                                                                                                     */
/* ....                                                                                                                    */
/*      X0       10.80                                                                                                     */
/*      3I       23.13                                                                                                     */
/*      X0        1.95                                                                                                     */
/*      X0       18.94                                                                                                     */
/*      3M        1.20                                                                                                     */
/***************************************************************************************************************************/

/*                             _
/ |  ___  __ _ ___   ___  __ _| |
| | / __|/ _` / __| / __|/ _` | |
| | \__ \ (_| \__ \ \__ \ (_| | |
|_| |___/\__,_|___/ |___/\__, |_|
                            |_|
*/

proc sql;
  create
     table prep as
  select
     company
    ,yoy
  from
     sd1.have
  order
    by company, yoy descending
;
  create
    table want as
  select
    company
   ,sum(yoy) as sumup3
  from
    %sqlpartition(prep,by=company)
  where
    partition <= 3
  group
    by company
;quit;

/**************************************************************************************************************************/
/* WORK. WANT total obs=4                                                                                                 */
/* Obs    COMPANY    SUMUP3                                                                                               */
/*                                                                                                                        */
/*  1       3I        34.75                                                                                               */
/*  2       3M        80.83                                                                                               */
/*  3       3P        41.42                                                                                               */
/*  4       X0        48.41                                                                                               */
/**************************************************************************************************************************/

/*___                     _
|___ \   _ __   ___  __ _| |
  __) | | `__| / __|/ _` | |
 / __/  | |    \__ \ (_| | |
|_____| |_|    |___/\__, |_|
                       |_|
*/

proc datasets lib=sd1 nolist nodetails;
 delete want;
run;quit;

%utl_rbeginx;
parmcards4;
library(haven)
library(sqldf)
source("c:/oto/fn_tosas9x.R")
options(sqldf.dll = "d:/dll/sqlean.dll")
have<-read_sas("d:/sd1/have.sas7bdat")
print(have)
want<-sqldf('
  with
    prep as (
  select
    company
   ,yoy
   ,rank() over (
        partition by company
        order by yoy desc
    ) as rank
 from
    have )
 select
    company
   ,sum(yoy) as sumup3
 from
    prep
 where
    rank <= 3
 group
    by company
')
want
fn_tosas9x(
      inp    = want
     ,outlib ="d:/sd1/"
     ,outdsn ="want"
     )
;;;;
%utl_rendx;

proc print data=sd1.want;
run;quit;

/**************************************************************************************************************************/
/* R                 SAS                                                                                                  */
/*   company sumup3  ROWNAMES    COMPANY    SUMUP3                                                                        */
/*                                                                                                                        */
/* 1      3I  34.75      1         3I        34.75                                                                        */
/* 2      3M  82.76      2         3M        82.76                                                                        */
/* 3      3P  41.42      3         3P        41.42                                                                        */
/* 4      X0  48.41      4         X0        48.41                                                                        */
/**************************************************************************************************************************/

/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
