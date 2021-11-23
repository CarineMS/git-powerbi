/* Retorne todos os registros dos funcionarios com 2 filhos */

SELECT * 
FROM cap16."TB_FUNC"
WHERE numero_filhos = '2'

/* SELECT * 
FROM cap16."TB_FUNC"
WHERE cast(numero_filhos as integer)= 2 */
