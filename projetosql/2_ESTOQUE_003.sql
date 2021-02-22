/*3.	Valoriza��o do estoque por linha de produto por pre�o de venda e custo


##### TABELAS ENVOLVIDAS  #####
# ESTOQUE                     #    
# MATERIAL_CUSTO              #    
# V_MATERIAL              #    
###############################
--REGRA VALOR UNITARIO DO v_MATERIAL
--REGRA ULTIMO PRECO DE CUSTO
*/

--SOLUCAO 1
 WITH T_VENDA_1 (COD_EMPRESA,COD_LINHA,VALOR_VENDA)
 AS
 ( SELECT A.COD_EMPRESA,B.COD_LINHA, SUM(A.QTD_SALDO*B.PRECO_UNIT) VALOR_VENDA
  FROM ESTOQUE A
   INNER JOIN  V_MATERIAL B
   ON A.COD_EMPRESA=B.COD_EMPRESA 
   AND A.COD_MAT=B.COD_MAT
   GROUP BY A.COD_EMPRESA,B.COD_LINHA
 ),
  T_CST_1 (COD_EMPRESA,COD_MAT,DATA_FIM)
  AS
  ( SELECT A.COD_EMPRESA,A.COD_MAT,MAX(A.DATA_FIM) AS DATA_FIM
	FROM MATERIAL_CUSTO A
	GROUP BY A.COD_EMPRESA,A.COD_MAT
	),

 T_CST_2 (COD_EMPRESA,COD_MAT,CUSTO_MEDIO)
  AS
  ( SELECT A.COD_EMPRESA,A.COD_MAT,A.CUSTO_MEDIO
	FROM MATERIAL_CUSTO A
	 INNER JOIN T_CST_1 B
	 ON A.COD_EMPRESA=B.COD_EMPRESA
	 AND A.COD_MAT=B.COD_MAT
	 AND A.DATA_FIM=B.DATA_FIM),

 T_CST_3 (COD_EMPRESA,COD_LINHA,VALOR_CUSTO)
  AS
   ( SELECT A.COD_EMPRESA,B.COD_LINHA, SUM(A.QTD_SALDO*C.CUSTO_MEDIO) VALOR_CUSTO
    FROM ESTOQUE A
	 INNER JOIN V_MATERIAL B
	 ON A.COD_EMPRESA=B.COD_EMPRESA
	 AND A.COD_MAT=B.COD_MAT
	 INNER JOIN T_CST_2 C
	 ON A.COD_EMPRESA=C.COD_EMPRESA
	 AND A.COD_MAT=C.COD_MAT
	 GROUP BY A.COD_EMPRESA,B.COD_LINHA
   )

     SELECT DISTINCT A.COD_EMPRESA,A.COD_LINHA,A.DESC_LINHA, B.VALOR_VENDA,C.VALOR_CUSTO
	  FROM V_MATERIAL A
	  INNER JOIN T_VENDA_1 B
	  ON A.COD_EMPRESA=B.COD_EMPRESA
	  AND A.COD_LINHA=B.COD_LINHA
	  INNER JOIN T_CST_3 C
	  ON A.COD_EMPRESA=C.COD_EMPRESA
	  AND A.COD_LINHA=C.COD_LINHA

  