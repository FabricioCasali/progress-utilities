
/*------------------------------------------------------------------------
    File        : validarDocumentos.i
    Purpose     : 

    Syntax      : 

    Description : 

    Author(s)   : fabriciocasali@gmail.com
    Created     : Fri May 21 10:24:07 BRT 2021
    Notes       : validar documentos padrão do Brasil
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */


/* ********************  Preprocessor Definitions  ******************** */

/* ************************  Function Prototypes ********************** */


function validarCNPJ returns logical 
    (ch-cnpj as character) forward.

function validarCPF returns logical 
    (ch-cpf as character) forward.


/* ***************************  Main Block  *************************** */

/* ************************  Function Implementations ***************** */


function validarCNPJ returns logical 
    (ch-cnpj as character ):
/*------------------------------------------------------------------------------
 Purpose:
 Notes:
------------------------------------------------------------------------------*/    

    
    define variable ch-base         as   character  no-undo.
    define variable in-mod          as   integer    no-undo.
    define variable ch-novo         as   character  no-undo.
    define variable in-conta        as   integer    no-undo.
    define variable in-soma         as   integer    no-undo.
    
    assign ch-base  = '6543298765432'
           ch-cnpj  = trim (replace (replace (replace (replace (ch-cnpj, '.', ''), '/', ''), '-', ''), ' ', ''))
           .
    
    if length (ch-cnpj) <> 14
    then do:
        return no.
    end.
    
    assign ch-novo = substring (ch-cnpj, 1, 12).
    
    do in-conta = 1 to 12 :
        assign in-soma = in-soma + (integer (substring (ch-base, in-conta + 1, 1)) * INTEGER (substring (ch-cnpj, in-conta, 1))).
    end.
        
    assign in-mod   = in-soma mod 11.
    
    if in-mod   < 2 
    then do:
         
        assign in-mod   = 0.
    end.
    else do:
        assign in-mod   = 11 - in-mod.
    end.     
     
    assign in-soma  = 0
           ch-novo  = substitute ('&1&2', ch-novo, in-mod).
     
    do in-conta = 1 to 13 :
        assign in-soma = in-soma + (integer (substring (ch-base, in-conta, 1)) * INTEGER (substring (ch-novo, in-conta, 1))).
    end.
         
    assign in-mod   = in-soma mod 11.
    
    if in-mod   < 2  
    then do:
         
        assign in-mod   = 0.
    end.
    else do:
        assign in-mod   = 11 - in-mod.
    end.    
    assign ch-novo  = substitute ('&1&2', ch-novo, in-mod).
    return ch-novo  = ch-cnpj.
end function.

function validarCPF returns logical 
    (ch-cpf as character   ):
/*------------------------------------------------------------------------------
 Purpose: verifica se o CPF é valido
 Notes:
------------------------------------------------------------------------------*/    

    define variable ch-cpf-limpo    as   character          no-undo.
    define variable in-multi1       as   integer extent 9   no-undo.
    define variable in-multi2       as   integer extent 10  no-undo.
    define variable in-indice       as   integer            no-undo.
    define variable in-resto        as   integer            no-undo.
    define variable ch-digito       as   character          no-undo.
    define variable ch-temp         as   character          no-undo.
    define variable in-soma         as   integer            no-undo.
    
    do in-indice = 1 to 9 :
        assign in-multi1[in-indice] = 12 - (in-indice + 1).
    end.
    do in-indice = 1 to 10:
        assign in-multi2[in-indice] = 13 - (in-indice + 1).
    end.
    
    assign ch-cpf-limpo = replace (replace (replace (ch-cpf, ' ', ''), '-', ''), '.', '').
    
    if length (ch-cpf-limpo)   <> 11 
    then do:
        
        return no.
    end.

    do in-indice = 0 to 9:
        
        assign ch-temp  = fill (string (in-indice), 11).
        
        if ch-temp  = ch-cpf-limpo 
        then do:
            
            return no.
        end.
    end.

    assign ch-temp  = substring (ch-cpf-limpo, 1, 10).
    
    do in-indice = 1 to 9:
    
        assign in-soma = in-soma + integer (substring (ch-temp, IN-indice, 1)) * in-multi1[in-indice].
    end.
    
    assign in-resto = in-soma mod 11.
    
    if in-resto < 2 
    then do:
        
        assign in-resto = 0.
    end.
    else do:
        
        assign in-resto = 11 - in-resto.
    end.
    
    assign ch-digito    = string (in-resto)
           ch-temp      = ch-temp + ch-digito
           in-soma      = 0.
           
    do in-indice = 1 to 10:
        assign in-soma  = in-soma + integer (substring (ch-temp, IN-indice, 1)) * in-multi2[in-indice].
    end.
    
    assign in-resto = in-soma mod 11.
    
    if in-resto < 2 
    then do:
        
        assign in-resto = 0.
    end.
    else do:
        
        assign in-resto = 11 - in-resto.
    end.
    assign ch-digito = ch-digito + string (in-resto).
    
    return substring (ch-cpf-limpo, 10) = ch-digito. 
end function.

