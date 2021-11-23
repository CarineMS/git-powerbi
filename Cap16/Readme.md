# Estudo de Caso Cap16

Para aprofundar no conhecimento de SQL Analytics foram realizados testes de aprendizado e um projeto com três instruções:

01) Crie uma intrução SQL que retorne a média de idade, número de filhos e grau de instrução dos funcionários cujo salario_hora estiver acima da média de todos os funcionários. Retorne os dados somente de funcionarios da capital e estado civil casado, com ordem decrescente da média da idade.
02) Retorne todos os registros dos funcionarios com dois filhos.
03) Retorne a média de salário hora por estado. 

# Testes
## Testes Query
```
/* Seleção da tabela */
  /* SELECT * FROM cap16."TB_FUNC" */
/* Seleção limitada da tabela */
  /* SELECT * FROM cap16."TB_FUNC" LIMIT 5 */
  /*SELECT * FROM cap16."TB_FUNC" FETCH FIRST 5 ROWS ONLY*/

/* Remoção de informações duplicadas */
  /* SELECT DISTINCT * FROM cap16."TB_FUNC" */
/* Remoção de informações duplicadas em uma coluna */
  /* SELECT DISTINCT NUMERO_FILHOS FROM cap16."TB_FUNC" */
  
/* Operadores de comparação */
/* WHERE */
  /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE = 30 */
/* CONT */  
 /* SELECT COUNT(*) FROM cap16."TB_FUNC"*/
/* COUNT+WHERE*/  
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE = 40 */
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE != 40 */
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE > 40 */
/* AND */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE < 30 AND estado_civil = 'casado'*/
/* OR */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE < 30 OR estado_civil = 'viuvo'*/
/* BETWEEN */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE >= 30 AND IDADE <= 35 */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE BETWEEN 30 AND 35 */
/* LIKE  */
 /* SELECT * FROM cap16."TB_FUNC" WHERE grau_instrucao LIKE '%medio'*/
/* IN */ 
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE IN(20, 30, 40, 50)*/
/* NULL */
 /* SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is null */
 /* SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is not null */
 
 
/* Instrução DNL */ 
 /* UPDATE cap16."TB_FUNC"
 SET numero_filhos = NULL 
 WHERE numero_filhos = 'NA';
 
 commit; */
 SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is NULL
```
## Testes comandos CREATE e INSERT
```
CREATE TABLE cap16."TB_ENDERECO"
(
    "id_end" integer NOT NULL,
    "rua" character varying(30),
    "numero" character varying(30),
    "bairro" character varying(30),
    "cep" character varying(10),
    "estado" character varying(30),
    "pais" character varying(30),
    "id_func" integer,
    PRIMARY KEY ("id_end")
)

TABLESPACE pg_default;

ALTER TABLE cap16."TB_ENDERECO"
    OWNER to postgres;


INSERT INTO cap16."TB_ENDERECO"(
	"id_end", "rua", "numero", "bairro", "cep", "estado", "pais", "id_func")
	VALUES (1001, 'Jaguar', 40, 'Tijuca', '24239-900', 'Rio de Janeiro', 'Brasil', 2);
	
INSERT INTO cap16."TB_ENDERECO"(
	"id_end", "rua", "numero", "bairro", "cep", "estado", "pais", "id_func")
	VALUES (1002, 'Mercedes Benz', 140, 'Centro', '12098-900', 'Minas Gerais', 'Brasil', 6);

INSERT INTO cap16."TB_ENDERECO"(
	"id_end", "rua", "numero", "bairro", "cep", "estado", "pais", "id_func")
	VALUES (1003, 'BMW', 20, 'Tijuca', '23232-900', 'Rio de Janeiro', 'Brasil', 3);
	
INSERT INTO cap16."TB_ENDERECO"(
	"id_end", "rua", "numero", "bairro", "cep", "estado", "pais", "id_func")
	VALUES (1004, 'Ferrari', 32, 'Centro', '99872-900', 'Minas Gerais', 'Brasil', 11);

INSERT INTO cap16."TB_ENDERECO"(
	"id_end", "rua", "numero", "bairro", "cep", "estado", "pais", "id_func")
	VALUES (1005, 'McLaren', 45, 'Centro', '43982-900', 'Minas Gerais', 'Brasil', 17);
```
## Testes Comando SELECT, UPDATE, DELETE, ORDER BY, GROUP BY
```
/* Seleção da tabela */
  /* SELECT * FROM cap16."TB_FUNC" */
/* Seleção limitada da tabela */
  /* SELECT * FROM cap16."TB_FUNC" LIMIT 5 */
  /*SELECT * FROM cap16."TB_FUNC" FETCH FIRST 5 ROWS ONLY*/

/* Remoção de informações duplicadas */
  /* SELECT DISTINCT * FROM cap16."TB_FUNC" */
/* Remoção de informações duplicadas em uma coluna */
  /* SELECT DISTINCT NUMERO_FILHOS FROM cap16."TB_FUNC" */
  
/* Operadores de comparação */
/* WHERE */
  /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE = 30 */
/* CONT */  
 /* SELECT COUNT(*) FROM cap16."TB_FUNC"*/
/* COUNT+WHERE*/  
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE = 40 */
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE != 40 */
 /* SELECT COUNT(*) FROM cap16."TB_FUNC" WHERE IDADE > 40 */
/* AND */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE < 30 AND estado_civil = 'casado'*/
/* OR */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE < 30 OR estado_civil = 'viuvo'*/
/* BETWEEN */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE >= 30 AND IDADE <= 35 */
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE BETWEEN 30 AND 35 */
/* LIKE  */
 /* SELECT * FROM cap16."TB_FUNC" WHERE grau_instrucao LIKE '%medio'*/
/* IN */ 
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE IN(20, 30, 40, 50)*/
/* NULL */
 /* SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is null */
 /* SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is not null */
 
 
/* Instrução DNL */ 
 /* UPDATE cap16."TB_FUNC"
 SET numero_filhos = NULL 
 WHERE numero_filhos = 'NA';
 
 commit; */
 /* SELECT * FROM cap16."TB_FUNC" WHERE numero_filhos is NULL */

/* DELET */
 /* DELETE FROM cap16."TB_FUNC"
 WHERE numero_filhos = 'NA';
 commit;*/
 
 /*	INSERT INTO cap16."TB_FUNC"(
	"ID", estado_civil, grau_instrucao, numero_filhos, salario_hora, idade, reg_procedencia)
	VALUES (38, 'casado', 'ensino medio', 3, 4.50, 30, 'capital');
 	commit; */	
 /* SELECT * FROM cap16."TB_FUNC" WHERE IDADE = 20 */

/* ORDER BY*/
 /* SELECT * FROM cap16."TB_FUNC" order by salario ASC*/
 /* SELECT * FROM cap16."TB_FUNC" order by salario_hora DESC*/
 /*SELECT * FROM cap16."TB_FUNC" order by salario_hora DESC, reg_procedencia DESC*/
/* MIN MAX*/
 /* SELECT MIN(salario_hora), MAX(salario_hora) from cap16."TB_FUNC"*/
 /* SELECT  AVG(salario_hora) from cap16."TB_FUNC" */
 /* SELECT MIN(salario_hora), MAX(salario_hora), AVG(salario_hora), COUNT(*), SUM(salario_hora) from cap16."TB_FUNC"*/

/* group by - sumarização */
 /* SELECT DISTINCT reg_procedencia FROM cap16."TB_FUNC"*/
/* Média do salario hora por região de procedencia */
 /* SELECT round(AVG(salario_hora)), reg_procedencia FROM cap16."TB_FUNC" group by reg_procedencia */
```
# Resolução da Tarefa
## 01) Crie uma intrução SQL que retorne a média de idade, número de filhos e grau de instrução dos funcionários cujo salario_hora estiver acima da média de todos os funcionários. Retorne os dados somente de funcionarios da capital e estado civil casado, com ordem decrescente da média da idade.
```
SELECT ROUND(AVG(idade)), numero_filhos, grau_instrucao
FROM cap16."TB_FUNC" 
WHERE reg_procedencia = 'capital'
  AND estado_civil = 'casado'
  AND salario_hora > (SELECT AVG(salario_hora) FROM cap16."TB_FUNC")
GROUP BY numero_filhos, grau_instrucao
ORDER BY round(AVG(idade)) DESC
```
## 02) Retorne todos os registros dos funcionarios com dois filhos.
```
SELECT * 
FROM cap16."TB_FUNC"
WHERE numero_filhos = '2'

/* SELECT * 
FROM cap16."TB_FUNC"
WHERE cast(numero_filhos as integer)= 2 */

```
## 03) Retorne a média de salário hora por estado. 
```
SELECT round(AVG(f.salario_hora)),e.estado
FROM cap16."TB_FUNC" f, cap16."TB_ENDERECO" e
WHERE "ID" = "id_func"
GROUP BY e.estado
```
