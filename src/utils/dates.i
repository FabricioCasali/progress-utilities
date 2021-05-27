
/*------------------------------------------------------------------------
    File        : dates.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : 
    Created     : Tue Oct 13 14:54:32 BRT 2015
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
define variable DATE_FORMAT_YYYY_MM_DD_WITH_SEP     as   character          no-undo initial "YYYY-MM-DD".
define variable DATE_FORMAT_DD_MM_YYYY_WITH_SEP     as   character          no-undo initial "DD-MM-YYYY".
define variable DATE_FORMAT_DD_MM_YYYY_WITHOUT_SEP  as   character          no-undo initial "DDMMYYYY".

/* ********************  Preprocessor Definitions  ******************** */

/* ************************  Function Prototypes ********************** */

function daysInMonth returns integer 
    (in-year as integer,
     in-month as integer) forward.

function firstDateOfMonth returns date 
    (in-year        as integer,
     in-month       as integer) forward.

function firstDayActualMonth returns date 
    (  ) forward.

function lastDayActualMonth returns date 
    (  ) forward.

function lastDayOfMonth returns date 
    (in-year        as   integer,
     in-month       as   integer) forward.



/* ***************************  Main Block  *************************** */




/* ************************  Function Implementations ***************** */

function daysInMonth returns integer 
    (in-year        as   integer,
     in-month       as   integer  ):
/*------------------------------------------------------------------------------
 Purpose: retorna a quantidade de dias de um determinado mês
 Notes:
------------------------------------------------------------------------------*/    

    define variable dt-start    as   date   no-undo.
    define variable dt-end      as   date   no-undo.
    
    assign dt-start = date (in-month, 1, in-year)
           dt-end   = lastDayOfMonth(in-year, in-month).
           
    return interval (dt-end, dt-start, "days") + 1.  
        
end function.

function firstDateOfMonth returns date 
    (in-year        as integer , 
     in-month       as integer   ):
/*------------------------------------------------------------------------------
 Purpose: retorna o primeiro dia do mes/ano recebido por parametro
 Notes:
------------------------------------------------------------------------------*/    

    return date (in-month, 1, in-year).

        
end function.

function firstDayActualMonth returns date 
    (  ):
/*------------------------------------------------------------------------------
 Purpose: 
 Notes:
------------------------------------------------------------------------------*/    

    return date (month (today), 1, year (today)).
        
end function.

function lastDayActualMonth returns date 
    (  ):
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/    

    return lastDayActualMonth (year (today), month (today)).

end function.

function lastDayOfMonth returns date 
    (in-year        as   integer,
     in-month       as   integer):
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/    

    define variable dt-last     as   date       no-undo.
         
    assign dt-last  = date (in-month, 1, in-year)
           dt-last  = add-interval (dt-last, 1, "month")
           dt-last  = dt-last - 1.
           
    return dt-last.           
end function.

