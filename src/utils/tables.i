
/*------------------------------------------------------------------------
    File        : tables.i
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : fabriciocasali@gmail.com 
    Created     : Fri May 21 10:35:29 BRT 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */

/* ************************  Function Prototypes ********************** */


function primaryKeyFields returns character 
    (  ) forward.

function regKey returns character 
    (  ) forward.


/* ***************************  Main Block  *************************** */

/* ************************  Function Implementations ***************** */


function primaryKeyFields returns character 
    (  ):
/*------------------------------------------------------------------------------
 Purpose: get a list of fields from the primary index of table. if table has no primary, return ''
 Notes:
------------------------------------------------------------------------------*/    
    define variable ch-keys          as character    no-undo.

    assign ch-keys = hd-temp-table:keys(1).    
    if ch-keys = "rowid"
    then do:
        return "".
    end.

    return ch-keys.
        
end function.

function regKey returns character 
    (  ):
/*------------------------------------------------------------------------------
 Purpose: returns a string with values of fields in the primary key of table
 Notes:
------------------------------------------------------------------------------*/    
    define variable ch-keys          as character    no-undo.
    define variable in-num-keys      as integer      no-undo.
    define variable in-index         as integer      no-undo.
    define variable ch-holder        as character    no-undo.
    define variable ch-value         as character    no-undo.

    assign ch-keys = primaryKeyFields(input hd-temp-table).
        
    assign in-num-keys = num-entries (ch-keys, ",").
    do in-index = 1 to in-num-keys:
        assign ch-value = hd-temp-table:buffer-field (entry (in-index, ch-keys, ",")):buffer-value no-error.
        if not error-status:error
        then do:
            if ch-holder <> '' then ch-holder = ch-holder + ':'.
            ch-holder = ch-holder + substitute ("&1", ch-value).
        end.        
    end.    
    return ch-holder.
end function.

