/* Retorne a média de salário hora por estado */

SELECT round(AVG(f.salario_hora)),e.estado
FROM cap16."TB_FUNC" f, cap16."TB_ENDERECO" e
WHERE "ID" = "id_func"
GROUP BY e.estado